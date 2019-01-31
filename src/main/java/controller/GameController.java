package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import domain.Game;
import domain.User;
import exception.InadequateFileExtException;
import service.FileService;
import service.GameService;

@Controller
public class GameController {

	@Autowired
	private GameService gameService;

	@Autowired
	private FileService fileService;

	@RequestMapping(value = "/game/main", method = RequestMethod.GET)
	public String main(Model model) {
		List<Game> gameList = gameService.gameList(20);
		List<Game> hotGameList = gameService.hotGameList();
		List<User> rankerList = gameService.rankerList(3);
		model.addAttribute("gameList", gameList);
		model.addAttribute("hotGameList", hotGameList);
		model.addAttribute("rankerList", rankerList);
		return "game/gameMain";
	}

	@RequestMapping(value = "/game/insert", method = RequestMethod.GET)
	public String insertGet(Model model) {
		model.addAttribute(new Game());
		return "game/insert";
	}
	
	@RequestMapping(value = "/game/insert", method = RequestMethod.POST)
	public String insertPost(@ModelAttribute @Valid Game game, BindingResult bindingResult, MultipartHttpServletRequest mtRequest,
			@AuthenticationPrincipal User user, Model model) {
		System.out.println(game.getSrc());
		if (bindingResult.hasErrors()) {
			return "/game/insert";
		}
		String path = mtRequest.getServletContext().getRealPath("/WEB-INF/upload/image");
		String filename;
		try {
			filename = fileService.saveImage(path, game.getImage_file());
		} catch (InadequateFileExtException e) {
			long time = System.currentTimeMillis();
			SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
			String str = dayTime.format(new Date(time));

			System.out.println(str + "사용자가 jsp나 asp, php 파일의 업로드를 시도함.");
			model.addAttribute("msg", "이미지 파일만 업로드할 수 있습니다.");
			model.addAttribute("url","/game/insert");
			return "result";
		}
		game.setImage(filename);

		List<MultipartFile> files = mtRequest.getFiles("files");
		String[] paths = new String[files.size()];
		paths = mtRequest.getParameter("paths").split(",");
		// String rootDir =
		// mtRequest.getServletContext().getRealPath("/WEB-INF/upload/game/")+mtRequest.getParameter("id")+"_"+paths[0].substring(0,
		// paths[0].indexOf("/"))+"/";
		game.setId(gameService.getNextId());
		String rootDir = "c:/test/" + game.getId() + "_" + paths[0].substring(0, paths[0].indexOf("/")) + "/";

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
		
		/*if (game.getType().equals("exe") || game.getType().equals("etc")) {
			path = request.getServletContext().getRealPath("/WEB-INF/upload/game");
			try {
				filename = fileService.saveFile(path, game.getGame_file());
			} catch (InadequateFileExtException e) {
				long time = System.currentTimeMillis();
				SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
				String str = dayTime.format(new Date(time));

				System.out.println(str + "사용자가 jsp나 asp, php 파일의 업로드를 시도함.");
				model.addAttribute("msg", "JSP, ASP, PHP 파일은 업로드할 수 없습니다.");
				model.addAttribute("url","/game/insert");
				return "result";
			}
			game.setSrc(filename);
		}*/

		game.setUsers_id(user.getId());
		gameService.insertGame(game);
		
		return "redirect:/game/list";
	}

	@RequestMapping(value = "/game/list", method = RequestMethod.GET)
	public String list(@RequestParam(required = false) String search, @RequestParam(defaultValue = "date") String type,
			Model model) {
		Map<String, String> map = new HashMap<>();
		map.put("search", search);
		map.put("type", type);
		List<Game> gameList = gameService.gameList(map);
		model.addAttribute("gameList", gameList);
		if (search != null) {
			model.addAttribute("search", search);
		}
		return "/game/list";
	}

	@RequestMapping(value="/game/view", method=RequestMethod.GET)
	public String gameView(@RequestParam(required=false) String id, Model model) {
		if(id == null) {
			return "redirect:/game/";
		}
		Game game = gameService.selectOne(id);
		if(game == null) {
			model.addAttribute("msg","없는 페이지입니다");
			model.addAttribute("url","/game/main");
			return "result";
		}
		model.addAttribute("game", game);
		return "game/view";
	}
	
}
