package service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import exception.InadequateFileExtException;

@Service
public class FileService {

	public String saveFile(String path, MultipartFile file) throws InadequateFileExtException {
		if (file.isEmpty()) {
			return "no_file";
		}

		String filename = file.getOriginalFilename();
		File f = new File(path, filename);
		while (f.exists()) {
			long time = System.currentTimeMillis();
			String ext = "";
			String name = filename;
			if (filename.lastIndexOf(".") != -1) {
				ext = filename.substring(filename.lastIndexOf("."));
				if (ext.toUpperCase().equals("JSP") || ext.toUpperCase().equals("ASP")
						|| ext.toUpperCase().equals("PHP")) {
					throw new InadequateFileExtException();
				}
				name = filename.substring(0, filename.lastIndexOf("."));
			}
			filename = name + "_" + time + ext;
			f = new File(path, filename);
		}
		try {
			file.transferTo(f);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		return filename;
	}

	public String saveImage(String path, MultipartFile file) throws InadequateFileExtException {
		if (file.isEmpty()) {
			return "no_file";
		}

		String filename = file.getOriginalFilename();
		File f = new File(path, filename);
		while (f.exists()) {
			long time = System.currentTimeMillis();
			String ext = "";
			String name = filename;
			if (filename.lastIndexOf(".") != -1) {
				ext = filename.substring(filename.lastIndexOf("."));
				name = filename.substring(0, filename.lastIndexOf("."));
			}
			filename = name + "_" + time + ext;
			f = new File(path, filename);
		}
		try {
			file.transferTo(f);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		if(!isImageFile(path+"\\"+filename)) {
			deleteFile(path, filename);
			throw new InadequateFileExtException();
		}
		return filename;
	}

	public void makeDirectory(String path) {
		File dir = new File(path);
		if (!dir.exists()) {
			dir.mkdirs();
			// System.out.println("created directory successfully!");
		} else {
			// System.out.println("directory already exists");
		}
	}

	public void deleteFile(String path, String filename) {
		File file = new File(path, filename);

		if (file.exists()) {
			if (file.delete()) {
				//System.out.println("파일삭제 성공");
			} else {
				//System.out.println("파일삭제 실패");
			}
		} else {
			System.out.println("파일이 존재하지 않습니다.");
		}
	}

	String resultcode = "";
	String resultmessage = "";

	// 이미지 파일 체크 로직

	public boolean isImageFile(String szFilePath) {

		boolean isRst = false;

		String szFileHeader = "";

		String[] szArrImgHeader =

				{ "47494638", "474946383761", "474946383761", "474946383761" // GIF Header

						, "89504E470D0A1A0A0000000D49484452" // PNG Header

						, "FFD8FF" // JPG Header

						, "424D" // BMP Header

				};

		try {

			if (szFilePath != null && !szFilePath.equals("")) {

				if (fileUploadCheckJpg(szFilePath)) {

					szFileHeader = fileToByte(szFilePath); // 업로드 하려는 파일 헤더 체크

					if (szFileHeader != null && !szFileHeader.equals("")) {

						for (int i = 0; i < szArrImgHeader.length; i++) {

							int len = szArrImgHeader[i].length();

							if (szArrImgHeader[i].equals(szFileHeader.substring(0, len))) {

								isRst = true;

								break;

							}

						}

					}

				}

			}

		} catch (Exception e) {

			// log기록 필요

		}

		return isRst;

	}

	// 파일 헤더 체크

	public String fileToByte(String szFilePath) throws Exception {

		byte[] b = new byte[16];

		String szFileHeader = "";

		DataInputStream in = null;

		try {

			// 파일을 DataInputStream에 넣고 byte array로 읽어들임.(담기)

			in = new DataInputStream(new FileInputStream(szFilePath));

			in.read(b);

			for (int i = 0; i < b.length; i++) {

				szFileHeader += byteToHex(b[i]);

			}

		} catch (Exception e) {

			// log 기록 필요

		} finally {

			if (in != null) {
				in.close();
			}

		}

		return szFileHeader;

	}

	// byte -> Hex(String)로 변경

	public String byteToHex(byte in) {

		byte ch = 0x00;

		String pseudo[] = { "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F" };

		StringBuffer out = new StringBuffer();

		ch = (byte) (in & 0xF0);

		ch = (byte) (ch >>> 4);

		ch = (byte) (ch & 0x0F);

		out.append(pseudo[(int) ch]);

		ch = (byte) (in & 0x0F);

		out.append(pseudo[(int) ch]);

		String rslt = new String(out);

		return rslt;

	}

	// 파일 확장자 체크

	public boolean fileUploadCheckJpg(String fileName) {

		boolean result = false;

		String check = fileName.substring(fileName.lastIndexOf("."));

		if (check.equalsIgnoreCase(".jpg") || check.equalsIgnoreCase(".bmp")

				|| check.equalsIgnoreCase(".gif") || check.equalsIgnoreCase(".png")) {

			result = true;

		}

		return result;

	}

	//파일 압축 (zip)
	/**
     * 디렉토리 및 파일을 압축한다.
     * @param path 압축할 디렉토리 및 파일
     * @param toPath 압축파일을 생성할 경로
     * @param fileName 압축파일의 이름
     */
    public String createZipFile(String path, String toPath, String fileName) {
 
        File dir = new File(path);
        String[] list = dir.list();
        String _path;
        String rootPath = path.replaceAll("/", "\\\\");
 
        if (!dir.canRead() || !dir.canWrite()) {
        	return "error";
        }
 
        int len = list.length;
 
        if (path.charAt(path.length() - 1) != '/') {
        	_path = path + "/";
        }else {
        	_path = path;
        }
 
        try {
            ZipOutputStream zip_out = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(toPath+"/"+fileName), 2048));
 
            for (int i = 0; i < len; i++)
                zip_folder("",new File(_path + list[i]), zip_out, rootPath);
 
            zip_out.close();
 
        } catch (FileNotFoundException e) {
            System.out.println("File not found"+ e.getMessage());
 
        } catch (IOException e) {
        	System.out.println("IOException"+ e.getMessage());
        } finally {
 
 
        }
        return fileName;
    }
 
    /**
     * ZipOutputStream를 넘겨 받아서 하나의 압축파일로 만든다.
     * @param parent 상위폴더명
     * @param file 압축할 파일
     * @param zout 압축전체스트림
     * @throws IOException
     */
    private void zip_folder(String parent, File file, ZipOutputStream zout, String rootPath) throws IOException {
        byte[] data = new byte[2048];
        int read;
 
        if (file.isFile()) {
            ZipEntry entry = new ZipEntry(parent + file.getName());
            zout.putNextEntry(entry);
            BufferedInputStream instream = new BufferedInputStream(new FileInputStream(file));
 
            while ((read = instream.read(data, 0, 2048)) != -1)
                zout.write(data, 0, read);
 
            zout.flush();
            zout.closeEntry();
            instream.close();
 
        } else if (file.isDirectory()) {
        	//폴더 경로 \로 표시
            String parentString = file.getPath().replace(rootPath,"");
            parentString = parentString.substring(0,parentString.length() - file.getName().length());
            ZipEntry entry = new ZipEntry(parentString+file.getName()+"/");
            zout.putNextEntry(entry);
 
            String[] list = file.list();
            if (list != null) {
                int len = list.length;
                for (int i = 0; i < len; i++) {
                    zip_folder(entry.getName(),new File(file.getPath() + "/" + list[i]), zout, rootPath);
                }
            }
        }
    }
 
    /**
     * 압축을 해제 한다
     *
     * @param zip_file
     * @param directory
     */
    public boolean extractZipFiles(String zip_file, String directory) {
        boolean result = false;
 
        byte[] data = new byte[2048];
        ZipEntry entry = null;
        ZipInputStream zipstream = null;
        FileOutputStream out = null;
 
        if (!(directory.charAt(directory.length() - 1) == '/')) {
        	directory += "/";
        }
 
        File destDir = new File(directory);
        boolean isDirExists = destDir.exists();
        boolean isDirMake = destDir.mkdirs();
 
        try {
            zipstream = new ZipInputStream(new FileInputStream(zip_file));
 
            while ((entry = zipstream.getNextEntry()) != null) {
 
                int read = 0;
                File entryFile;
 
                //디렉토리의 경우 폴더를 생성한다.
                if (entry.isDirectory()) {
                    File folder = new File(directory+entry.getName());
                    if(!folder.exists()){
                        folder.mkdirs();
                    }
                    continue;
                }else {
                    entryFile = new File(directory + entry.getName());
                }
 
                if (!entryFile.exists()) {
                    boolean isFileMake = entryFile.createNewFile();
                }
 
                out = new FileOutputStream(entryFile);
                while ((read = zipstream.read(data, 0, 2048)) != -1)
                    out.write(data, 0, read);
 
                zipstream.closeEntry();
 
            }
 
            result = true;
        } catch (FileNotFoundException e) {
            e.printStackTrace();
            result = false;
        } catch (IOException e) {
            e.printStackTrace();
            result = false;
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
 
            if (zipstream != null) {
                try {
                    zipstream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
 
        return result;
    }
	
}
