package controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import domain.User;
import service.FileService;
import service.UserService;
import util.VerifyRecaptcha;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private FileService fileService;
	
	@Autowired
	private HttpSession session;
	
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
	public String joinPost(@ModelAttribute @Valid User user, BindingResult bindingResult, @RequestParam(value="g-recaptcha-response") String response) {
		System.out.println(response);
		try {
			if(!VerifyRecaptcha.verify(response)) {
				return "/user/join";
			}
			System.out.println("verify recapcha");
		} catch (IOException e1) {
			e1.printStackTrace();
			return "/user/join";
		}
		if(bindingResult.hasErrors()) {
			for(ObjectError e : bindingResult.getAllErrors()) {
				System.out.println(e.getDefaultMessage());
			}
			return "/user/join";
		}
		if(userService.selectOne(user.getId()) != null) {
			return "/user/join";
		}
		if(!((String)session.getAttribute("email")).equals(user.getEmail())) {
			return "/user/join";
		}
		System.out.println(user.getImage_file());
		String path = session.getServletContext().getRealPath("/WEB-INF/upload/image");
		String filename = fileService.saveFile(path, user.getImage_file());
		user.setImage(filename);
		userService.insert(user);
		
		return "redirect:/?signin";
	}
	
	@RequestMapping(value="/user/dualcheck/nickname", method=RequestMethod.POST)
	@ResponseBody
	public int nickNameDualCheck(@RequestParam String input) {
		int count = userService.nicknameDualCheck(input);
		return count;
	}
	
	@RequestMapping(value="/user/dualcheck/id", method=RequestMethod.POST)
	@ResponseBody
	public String idDualCheck(@RequestParam String id) {
		if(userService.selectOne(id) == null) {
			return "not duplicated";
		}
		return "duplicated";
	}
	
	@RequestMapping(value="/user/mypage",method=RequestMethod.GET)
	public String getMypage(@AuthenticationPrincipal User user,Model model) {
		model.addAttribute("lev",user.getLev());
		model.addAttribute("exp",user.getExp());
		model.addAttribute("image",user.getImage());
		model.addAttribute("user",user);
		return "/user/mypage";
	}
	
	@RequestMapping(value="/user/checkPassword",method=RequestMethod.GET)
	@ResponseBody
	public String checkPassword(@AuthenticationPrincipal User user,
			@RequestParam String id, @RequestParam String password) {
		if(user.getId().equals(id) && user.getPassword().equals(password)) {
			return "correct";
		}
		
		return "incorrect";
	}
	
	@RequestMapping(value = "/user/sendEmail", method = RequestMethod.POST)
	@ResponseBody
	public String checkEmail(@RequestParam String email) {
		if(!userService.checkValidEmail(email)) {
			return "unvalidEmail";
		}
		if(userService.dupCheckEmail(email) ) {
			return "duplicatedEmail";
		}
		String emailCode ="";
		try {
			emailCode = userService.sendCertifyEmail(email);
		} catch (Exception e) {
			return "error";
		}
		
		session.setAttribute("email", email);
		session.setAttribute("emailCode", emailCode);
		return "success";
	}
	
	@RequestMapping(value = "/user/checkEmailCode", method = RequestMethod.POST)
	@ResponseBody
	public String checkEmailCode(@RequestParam String email, @RequestParam String emailCode) {
		
		if(!((String)session.getAttribute("email")).equals(email)) {
			return "wrongEmail";
		}else if(!((String)session.getAttribute("emailCode")).equals(emailCode)) {
			return "wrongEmailCode";
		}
		
		return "success";
		
	}
	
	@RequestMapping(value="/user/update",method=RequestMethod.GET)
	public String update(@AuthenticationPrincipal User user,
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
	
	
	@RequestMapping(value="/user/delete",method=RequestMethod.GET)
	public String delete(@AuthenticationPrincipal User user,@RequestParam String id,Model model) {
		if(user.getId().equals(id)) {
			userService.delete(id);
			model.addAttribute("msg","회원탈퇴가 정상적으로 되었습니다");
			model.addAttribute("url","/?signout");
		}else {
			model.addAttribute("msg","잘못된 접근입니다");
			model.addAttribute("url","/");
		}
		return "/result";
	}
}
