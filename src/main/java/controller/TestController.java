package controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import service.FileService;

@Controller
public class TestController {

	@Autowired
	private FileService fileService;
	
	@RequestMapping(value="/test", method=RequestMethod.GET)
	public String test() {
		return "test";
	}
	
	@RequestMapping(value="/test/game/upload", method=RequestMethod.POST)
	public String uploadGame(MultipartHttpServletRequest mtRequest) {
		List<MultipartFile> files = mtRequest.getFiles("files");
		String[] paths = new String[files.size()];
		paths = mtRequest.getParameter("paths").split(",");
		//String rootDir = mtRequest.getServletContext().getRealPath("/WEB-INF/upload/game/")+mtRequest.getParameter("id")+"_"+paths[0].substring(0, paths[0].indexOf("/"))+"/";
		String rootDir = "c:/test/"+mtRequest.getParameter("id")+"_"+paths[0].substring(0, paths[0].indexOf("/"))+"/";

		fileService.makeDirectory(rootDir);
		
		for(int i = 0; i < paths.length; i++) {
			paths[i] = paths[i].substring(paths[i].indexOf("/")+1);
			if(paths[i].indexOf("/") != -1) {
				paths[i] = paths[i].substring(0, paths[i].lastIndexOf("/"));
				fileService.makeDirectory(rootDir+"/"+paths[i]);
			}
			fileService.saveFile(rootDir+paths[i], files.get(i));
		}
		return "redirect:/test";
	}
	
}
