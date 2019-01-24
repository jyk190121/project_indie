package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import domain.Game;
import domain.User;
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
	public String insertPost(@ModelAttribute @Valid Game game, BindingResult bindingResult, HttpServletRequest request,
			@AuthenticationPrincipal User user) {
		System.out.println(game.getSrc());
		if (bindingResult.hasErrors()) {
			return "/game/insert";
		}
		String path = request.getServletContext().getRealPath("/WEB-INF/upload/image");
		String filename = fileService.saveFile(path, game.getImage_file());
		game.setImage(filename);

		if (game.getType().equals("exe") || game.getType().equals("etc")) {
			path = request.getServletContext().getRealPath("/WEB-INF/upload/game");
			filename = fileService.saveFile(path, game.getGame_file());
			game.setSrc(filename);
		}

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

}
