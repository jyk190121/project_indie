package controller;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import exception.InadequateFileExtException;
import service.FileService;

@Controller
public class FileController {

	@Autowired
	private FileService fileService;

	@Autowired
	private ServletContext application;

	@RequestMapping(value = "/fileupload", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, String> fileUpload(@RequestParam MultipartFile upload) {
		String path = application.getRealPath("/WEB-INF/upload/image");

		String filename = "";
		try {
			filename = fileService.saveFile(path, upload);
		} catch (InadequateFileExtException e) {
			e.printStackTrace();
		}
		Map<String, String> map = new HashMap<>();
		map.put("url", "/upload/image/" + filename);

		return map;
	}

	@RequestMapping(value = "/filedelete", method = RequestMethod.POST, produces = "application/json; charset=utf-8")
	@ResponseBody
	public String fileDelete(@RequestParam String src) {
		String path = application.getRealPath(src);
		File target = new File(path);
		
		if (target.exists()) {
			target.delete();
			return "성공";
		} else {
			return "실패";
		}
	}

}
