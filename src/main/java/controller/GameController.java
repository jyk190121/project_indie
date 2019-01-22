package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import domain.Game;
import domain.User;
import service.GameService;

@Controller
public class GameController {

	@Autowired
	private GameService gameService;
	
	@RequestMapping(value="/game/main", method=RequestMethod.GET)
	public String main(Model model) {
		long time = System.currentTimeMillis();
		List<Game> gameList = gameService.gameList(20);
		System.out.println(System.currentTimeMillis()-time);
		time = System.currentTimeMillis();
		List<Game> hotGameList = gameService.hotGameList();
		System.out.println(System.currentTimeMillis()-time);
		time = System.currentTimeMillis();
		List<User> rankerList = gameService.rankerList(3);
		System.out.println(System.currentTimeMillis()-time);
		model.addAttribute("gameList", gameList);
		model.addAttribute("hotGameList", hotGameList);
		model.addAttribute("rankerList", rankerList);
		return "game/gameMain";
	}
	
	@RequestMapping(value="/game/insert", method=RequestMethod.GET)
	public String insertGet() {
		return "game/insert";
	}
	
	@RequestMapping(value="/game/insert", method=RequestMethod.POST)
	public String insertPost() {
		
		return "/game/list";
	}
	
	@RequestMapping(value="/game/list", method=RequestMethod.GET)
	public String list(@RequestParam(required=false) String search, @RequestParam(defaultValue="date") String type, Model model) {
		Map<String, String> map = new HashMap<>();
		map.put("search", search);
		map.put("type", type);
		List<Game> gameList = gameService.gameList(map);
		model.addAttribute("gameList", gameList);
		if(search != null) {
			model.addAttribute("search", search);
		}
		return "/game/list";
	}
	
}
