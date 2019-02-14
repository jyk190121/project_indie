package controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import exception.InadequateFileExtException;
import service.FileService;

@Controller
public class TestController {

	@Autowired
	private FileService fileService;

	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test() {
		return "test";
	}
	
	@RequestMapping(value="/test/zip", method=RequestMethod.GET)
	public String zip() throws IOException {
		String rootPath = "/WEB-INF/upload/game/";
		String rootPathStr = rootPath.replaceAll("/", "\\\\");
		System.out.println(rootPathStr);
		//fileService.createZipFile("c:/test/zip/clumsy-bird-ziptest", "c:/test/zip", "zipfiletest.zip");
		return "test";
	}

	@RequestMapping(value = "/test/game/upload", method = RequestMethod.POST)
	public String uploadGame(MultipartHttpServletRequest mtRequest) {
		List<MultipartFile> files = mtRequest.getFiles("files");
		String[] paths = new String[files.size()];
		paths = mtRequest.getParameter("paths").split(",");
		// String rootDir =
		// mtRequest.getServletContext().getRealPath("/WEB-INF/upload/game/")+mtRequest.getParameter("id")+"_"+paths[0].substring(0,
		// paths[0].indexOf("/"))+"/";
		String rootDir = "c:/test/" + mtRequest.getParameter("id") + "_" + paths[0].substring(0, paths[0].indexOf("/"))
				+ "/";

		fileService.makeDirectory(rootDir);

		for (int i = 0; i < paths.length; i++) {
			paths[i] = paths[i].substring(paths[i].indexOf("/") + 1);
			if (paths[i].indexOf("/") != -1) {
				paths[i] = paths[i].substring(0, paths[i].lastIndexOf("/"));
				fileService.makeDirectory(rootDir + "/" + paths[i]);
			} else {
				paths[i] = "";
			}
			try {
				fileService.saveFile(rootDir + paths[i], files.get(i));
			} catch (InadequateFileExtException e) {
				long time = System.currentTimeMillis();
				SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
				String str = dayTime.format(new Date(time));

				System.out.println(str + "사용자가 jsp나 asp, php 파일의 업로드를 시도함.");
			}
		}
		return "redirect:/test";
	}

	@RequestMapping(value="/test/upload/image", method=RequestMethod.POST)
	public String imageUpload(MultipartHttpServletRequest mtRequest) {
		MultipartFile image = mtRequest.getFile("image");
		String rootDir = "c:/test/";
		String pathname = "";
		try {
			pathname = rootDir+fileService.saveFile(rootDir, image);
		} catch (InadequateFileExtException e) {
			e.printStackTrace();
		}
		System.out.println(pathname);
		if(!fileService.isImageFile(pathname)) {
			System.out.println("이미지 파일이 아닙니다");
			//fileService.deleteFile(roo, filename);
		}else {
			System.out.println("이미지 파일입니다");
		}
		return "test";
	}
	
	
}
