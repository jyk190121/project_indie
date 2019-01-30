package service;

import java.io.File;
import java.io.IOException;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import exception.InadequateFileExtException;

@Service
public class FileService {

	public String saveFile(String path, MultipartFile file) throws InadequateFileExtException{
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
				if(ext.toUpperCase().equals("JSP") || ext.toUpperCase().equals("ASP") || ext.toUpperCase().equals("PHP")) {
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
	
	public String saveImage(String path, MultipartFile file) throws InadequateFileExtException{
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
				if(ext.toUpperCase().equals("JSP") || ext.toUpperCase().equals("ASP") || ext.toUpperCase().equals("PHP")) {
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

	public void makeDirectory(String path) {
		File dir = new File(path);
		if (!dir.exists()) {
			dir.mkdirs();
			// System.out.println("created directory successfully!");
		} else {
			// System.out.println("directory already exists");
		}
	}
}
