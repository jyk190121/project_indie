package controller;

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

import domain.Board;
import domain.User;
import service.UserService;
import util.Role;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@RequestMapping(value= {"/","/main"}, method=RequestMethod.GET)
	public String main(@AuthenticationPrincipal User user, Model model) {
		model.addAttribute("user", user);
		return "main";
	}
	
	@RequestMapping(value="/user/join", method=RequestMethod.GET)
	public String joinGet(Model model) {
		model.addAttribute(new User());
		return "user/join";
	}
	
	@RequestMapping(value="/user/join", method=RequestMethod.POST)
	public String joinPost(@ModelAttribute @Valid User user, BindingResult bindingResult) {
		if(bindingResult.hasErrors()) {
			return "/user/join";
		}
		return "redirect:/?signin";
	}
	
	@RequestMapping(value="/user/dualCheck", method=RequestMethod.POST)
	@ResponseBody
	public int nickNameDualCheck(@RequestParam String input) {
		int count = userService.nicknameDualCheck(input);
		return count;
	}
	
	@RequestMapping(value="/user/mypage",method=RequestMethod.GET)
	public String getMypage(@AuthenticationPrincipal User user,Model model) {
		model.addAttribute("user",user);
		return "/user/mypage";
	}
	
	/*@RequestMapping(value="/user/mypage",method=RequestMethod.POST)
	public String postMypage(@AuthenticationPrincipal User user,
			@RequestParam String id,@RequestParam String password,Model model) {
		if(user.getPassword().equals(password)) {
			model.addAttribute("user",user);
			model.addAttribute("url","/user/update"); 
		}else {
			model.addAttribute("msg","잘못된 요청입니다");
			model.addAttribute("url","/");
		}
		return "/result";
	}*/
	
	@RequestMapping(value="/user/checkPassword",method=RequestMethod.GET)
	@ResponseBody
	public String checkPassword(@AuthenticationPrincipal User user,
			@RequestParam String id, @RequestParam String password) {
		if(user.getId().equals(id) && user.getPassword().equals(password)) {
			return "correct";
		}
		
		return "incorrect";
	}
	
	
	@RequestMapping(value="/user/update",method=RequestMethod.GET)
	public String getUpdate(@AuthenticationPrincipal User user,
			@RequestParam String id, @RequestParam String password,Model model) {
		if(user.getId().equals(id) && user.getPassword().equals(password)) {
			model.addAttribute("user",user);
			return "/user/update";
		}else {
			model.addAttribute("msg","잘못된 요청입니다");
			model.addAttribute("url","/main");
			return "/result";
		}
	}
	
	/*@RequestMapping(value="/user/update",method=RequestMethod.POST)
	public String postUpdate(@AuthenticationPrincipal @Valid User user,
						BindingResult bindingResult, Model model) {
		if(bindingResult.hasErrors()) {
			return "/user/mypage";
		}
		User existUser = userService.userSelect(user.getId());
		if(user.getPassword().equals(existUser.getPassword())) {
			userService.update(user);
			return "redirect: /user/mypage";
		}else {
			model.addAttribute("msg","잘못된 요청입니다");
			model.addAttribute("url","/main");
			return "/result";
		}
		
	}*/
	
	@RequestMapping(value="/user/userChange",method=RequestMethod.GET)
	@ResponseBody
	public String userChange(@AuthenticationPrincipal User user,@RequestParam String id,
			@RequestParam String password, @RequestParam String nickname,@RequestParam String image,
			@RequestParam String myinfo,Model model) {
		if(user.getId().equals(id)) {
		user.setPassword(password);
		user.setNickname(nickname);
		user.setImage(image);
		user.setMyinfo(myinfo);
		/*if(image.equals(null)) {
			user.setImage("default.png");
		}*/
		userService.update(user);
		return "/user/mypage";
		}else {
		model.addAttribute("msg","잘못된 요청입니다");
		model.addAttribute("url","/main");
		return "/result";
		}
	}
}
