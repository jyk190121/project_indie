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
	public String getMypage(@ModelAttribute User user,Model model) {
		model.addAttribute("user",user);
		return "/user/mypage";
	}
	
	@RequestMapping(value="/user/mypage",method=RequestMethod.POST)
	public String postMypage(@ModelAttribute User user,
			@RequestParam String id,@RequestParam String password,Model model) {
		User existUser = userService.userSelect(id);
		if(user.getPassword().equals(existUser.getPassword())) {
			model.addAttribute("user",user);
			model.addAttribute("msg","correct");
			return "/user/update";
		}else {
			model.addAttribute("msg","잘못된 요청입니다");
			model.addAttribute("url","/");
			return "/result";
		}
	}
	
	@RequestMapping(value="/user/update",method=RequestMethod.GET)
	public String getUpdate(@ModelAttribute User user,
			@RequestParam String id,@RequestParam String password,Model model) {
		User existUser = userService.userSelect(id);
		if(user.getPassword().equals(existUser.getPassword())) {
			model.addAttribute("user",user);
			model.addAttribute("msg","회원정보가 수정되었습니다");
			return "/user/mypage";
		}else {
			model.addAttribute("msg","잘못된 요청입니다");
			model.addAttribute("url","/");
		}
		return "/result";
	}
	
	@RequestMapping(value="/user/update",method=RequestMethod.POST)
	public String postUpdate(@ModelAttribute @Valid User user,
						BindingResult bindingResult, Model model) {
		User existUser = userService.userSelect(user.getId());
		if(user.getPassword().equals(existUser.getPassword())) {
			if(bindingResult.hasErrors()) {
				return "/user/mypage";
			}
			userService.update(user);
			return "redirect: /";
		}else {
			model.addAttribute("msg","잘못된 요청입니다");
			model.addAttribute("url","/");
			return "/result";
		}
		
	}
}
