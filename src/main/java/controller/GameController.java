package controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import domain.Game;
import domain.GameLike;
import domain.User;
import exception.InadequateFileExtException;
import service.FileService;
import service.GameService;
import service.UserService;
import util.Clock;

@Controller
public class GameController {

	@Autowired
	private GameService gameService;

	@Autowired
	private FileService fileService;

	@Autowired
	private UserService userService;

	@RequestMapping(value = "/game/main", method = RequestMethod.GET)
	public String main(Model model) {
		List<Game> gameList = gameService.gameList(30);
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
		return "/game/insert";
	}

	@RequestMapping(value = "/game/insert", method = RequestMethod.POST)
	public String insertPost(@ModelAttribute @Valid Game game, BindingResult bindingResult,
			MultipartHttpServletRequest mtRequest, @AuthenticationPrincipal User user, Model model) {
		if (bindingResult.hasErrors()) {
			return "/game/insert";
		}
		String srcPath = mtRequest.getParameter("srcPath");
		if(game.getType().equals("web")) {
			if(srcPath == null) {
				model.addAttribute("msg", "잘못된 접근입니다.");
				model.addAttribute("url", "/game/insert");
				return "result";
			}
			game.setSrc(srcPath);
		}
		if(game.getImage_file().getSize() == 0) {
			model.addAttribute("msg", "잘못된 접근입니다.");
			model.addAttribute("url", "/game/insert");
			return "result";
		}
		List<MultipartFile> files = mtRequest.getFiles("gameFiles");
		for(MultipartFile file : files) {
			if(file.getSize() == 0) {
				model.addAttribute("msg", "잘못된 접근입니다.");
				model.addAttribute("url", "/game/insert");
				return "result";
			}
		}
		String path = mtRequest.getServletContext().getRealPath("/WEB-INF/upload/image/");
		String filename;
		try {
			filename = fileService.saveImage(path, game.getImage_file());
		} catch (InadequateFileExtException e) {
			model.addAttribute("msg", "이미지 파일만 업로드할 수 있습니다.");
			model.addAttribute("url", "/game/insert");
			return "result";
		}
		game.setImage(filename);

		
		String[] paths = new String[files.size()];
		paths = mtRequest.getParameter("paths").split(",");
		
		game.setId(gameService.getNextId());
		String rootDir = mtRequest.getServletContext().getRealPath("/WEB-INF/upload/game/")
				+ game.getId() + "/";
		//String rootDir = "c:/test/" + game.getId() + "_" + game.getName() + "/";

		fileService.makeDirectory(rootDir);

		for (int i = 0; i < paths.length; i++) {	
			if (paths[i].indexOf("/") != -1) {
				paths[i] = paths[i].substring(0, paths[i].lastIndexOf("/"));
				fileService.makeDirectory(rootDir + "/" + paths[i]);
			} else {
				paths[i] = "";
			}
			try {
				fileService.saveFile(rootDir + paths[i], files.get(i));
			}catch (InadequateFileExtException e) {
				System.out.println(Clock.getCurrentTime() + " : 사용자가 jsp나 asp, php 파일의 업로드를 시도함.");
				model.addAttribute("msg", "JSP, ASP, PHP 파일은 업로드할 수 없습니다.");
				model.addAttribute("url", "/game/insert");
				return "/result";
			}
		}
		
		if(!game.getType().equals("web")) {
			String zipPath = rootDir.substring(0, rootDir.length()-1);
			String zipName = fileService.createZipFile(zipPath, zipPath, "indiemoa_"+game.getName());
			if(zipName == "error") {
				return "/error500";
			}
			game.setSrc(zipName);
		}
		game.setUsers_id(user.getId());
		gameService.insertGame(game);
		userService.getExp(user.getId(), 100);
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

	@RequestMapping(value = "/game/view", method = RequestMethod.GET)
	public String gameView(@RequestParam(required = false) String id, Model model, @AuthenticationPrincipal User user,
			@ModelAttribute Game game) {
		if (id == null) {
			return "redirect:/game/";
		}
		model.addAttribute("game",gameService.selectOne(id));
		if (gameService.selectOne(id) == null) {
			model.addAttribute("msg", "잘못된 요청입니다");
			model.addAttribute("url", "/game/main");
			return "result";
		}
		GameLike eval = new GameLike();
		eval.setGame_id(id);
		eval.setUsers_id(user.getId());
		if(gameService.selectGameLike(eval) != null) {
			model.addAttribute("selectedEval", gameService.selectGameLike(eval).getType());
		}
		return "game/view";
	}

	@RequestMapping(value="/game/evaluate", method=RequestMethod.POST)
	@ResponseBody
	public String evaluate(@ModelAttribute GameLike input, @AuthenticationPrincipal User user) {
		if(!(input.getType().equals("like") || input.getType().equals("unlike"))){
			return "invalid type";
		}
		input.setUsers_id(user.getId());
		Game game = gameService.selectOne(String.valueOf(input.getGame_id()));
		if(gameService.isEvaluationExisting(input)){
			String existingType = gameService.selectGameLike(input).getType();
			if(!existingType.equals(input.getType())) {
				gameService.updateEvalCount(input.getGame_id(), existingType, game.getEvalCount(existingType)-1);
				gameService.updateGameLike(input);
			}else {
				Game g = gameService.selectOne(String.valueOf(input.getGame_id()));
				return input.getType()+","+g.getLikes()+","+g.getUnlikes();
			}
		}else {
			gameService.insertGameLike(input);
		}
		gameService.updateEvalCount(input.getGame_id(), input.getType(), game.getEvalCount(input.getType())+1);
		Game g = gameService.selectOne(String.valueOf(input.getGame_id()));
		return input.getType()+","+g.getLikes()+","+g.getUnlikes();
	}
	
	
}
