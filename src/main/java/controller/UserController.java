package controller;

import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import domain.User;

@Controller
public class UserController {

	@RequestMapping(value= {"/","/main"}, method=RequestMethod.GET)
	public String main(@AuthenticationPrincipal User user, Model model) {
		System.out.println(user);
		model.addAttribute("user", user);
		return "main";
	}
	
}
