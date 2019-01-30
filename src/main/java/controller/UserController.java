package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

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

import domain.Board;
import domain.User;
import exception.InadequateFileExtException;
import service.FileService;
import service.UserService;
import util.Pager;
import util.VerifyRecaptcha;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private FileService fileService;

	@Autowired
	private HttpSession session;

	@RequestMapping(value = { "/", "/main" }, method = RequestMethod.GET)
	public String main(@AuthenticationPrincipal User user, Model model) {
		model.addAttribute("user", user);
		return "main";
	}

	@RequestMapping(value = "/user/join", method = RequestMethod.GET)
	public String joinGet(Model model) {
		model.addAttribute(new User());
		return "user/join";
	}

	@RequestMapping(value = "/user/join", method = RequestMethod.POST)
	public String joinPost(@ModelAttribute @Valid User user, BindingResult bindingResult,
			@RequestParam(value = "g-recaptcha-response") String response, Model model) {
		System.out.println(response);
		try {
			if (!VerifyRecaptcha.verify(response)) {
				return "/user/join";
			}
			System.out.println("verify recapcha");
		} catch (IOException e1) {
			e1.printStackTrace();
			return "/user/join";
		}
		if (bindingResult.hasErrors()) {
			for (ObjectError e : bindingResult.getAllErrors()) {
				System.out.println(e.getDefaultMessage());
			}
			return "/user/join";
		}
		if (userService.selectOne(user.getId()) != null) {
			return "/user/join";
		}
		if (!((String) session.getAttribute("email")).equals(user.getEmail())) {
			return "/user/join";
		}
		System.out.println(user.getImage_file());
		String path = session.getServletContext().getRealPath("/WEB-INF/upload/image");
		String filename;
		try {
			filename = fileService.saveFile(path, user.getImage_file());
		} catch (InadequateFileExtException e) {
			long time = System.currentTimeMillis();
			SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
			String str = dayTime.format(new Date(time));

			System.out.println(str + "사용자가 jsp나 asp, php 파일의 업로드를 시도함.");
			model.addAttribute("msg", "JSP, ASP, PHP 파일은 업로드할 수 없습니다.");
			model.addAttribute("url","/game/insert");
			return "result";
		}
		user.setImage(filename);
		userService.insert(user);

		return "redirect:/?signin";
	}

	@RequestMapping(value = "/user/dualcheck/nickname", method = RequestMethod.POST)
	@ResponseBody
	public int nickNameDualCheck(@RequestParam String input) {
		int count = userService.nicknameDualCheck(input);
		return count;
	}

	@RequestMapping(value = "/user/dualcheck/id", method = RequestMethod.POST)
	@ResponseBody
	public String idDualCheck(@RequestParam String id) {
		if (userService.selectOne(id) == null) {
			return "not duplicated";
		}
		return "duplicated";
	}

	@RequestMapping(value = "/user/mypage", method = RequestMethod.GET)
	public String getMypage(@AuthenticationPrincipal User user, Model model) {
		model.addAttribute("lev", user.getLev());
		model.addAttribute("exp", user.getExp());
		model.addAttribute("image", user.getImage());
		model.addAttribute("user", user);
		return "/user/mypage";
	}

	@RequestMapping(value = "/user/checkPassword", method = RequestMethod.GET)
	@ResponseBody
	public String checkPassword(@AuthenticationPrincipal User user, @RequestParam String id,
			@RequestParam String password) {
		if (user.getId().equals(id) && user.getPassword().equals(password)) {
			return "correct";
		}

		return "incorrect";
	}

	@RequestMapping(value = "/user/sendEmail", method = RequestMethod.POST)
	@ResponseBody
	public String checkEmail(@RequestParam String email) {
		if (!userService.checkValidEmail(email)) {
			return "unvalidEmail";
		}
		if (userService.dupCheckEmail(email)) {
			return "duplicatedEmail";
		}
		String emailCode = "";
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

		if (!((String) session.getAttribute("email")).equals(email)) {
			return "wrongEmail";
		} else if (!((String) session.getAttribute("emailCode")).equals(emailCode)) {
			return "wrongEmailCode";
		}

		return "success";

	}

	@RequestMapping(value = "/user/update", method = RequestMethod.GET)
	public String update(@AuthenticationPrincipal User user, @RequestParam String id, @RequestParam String password,
			Model model) {
		if (user.getId().equals(id) && user.getPassword().equals(password)) {
			model.addAttribute("user", user);
			return "/user/update";
		} else {
			model.addAttribute("msg", "잘못된 요청입니다");
			model.addAttribute("url", "/main");
			return "/result";
		}
	}
	
	
	@RequestMapping(value="/user/userChange",method=RequestMethod.GET)
	@ResponseBody
	public String userChange(@AuthenticationPrincipal User user, @RequestParam String id, @RequestParam String password,
			@RequestParam String nickname, @RequestParam String image, @RequestParam String myinfo, Model model) {
		if (user.getId().equals(id)) {
			user.setPassword(password);
			user.setNickname(nickname);
			user.setImage(image);
			user.setMyinfo(myinfo);
			/*
			 * if(image.equals(null)) { user.setImage("default.png"); }
			 */
			userService.update(user);
			return "/user/mypage";
		} else {
			model.addAttribute("msg", "잘못된 요청입니다");
			model.addAttribute("url", "/main");
			return "/result";
		}
	}
	
	@RequestMapping(value="/user/delete",method=RequestMethod.GET)
	public String delete(@AuthenticationPrincipal User user,@RequestParam String id,@RequestParam String password,
			Model model) {
		if(user.getId().equals(id) && user.getPassword().equals(password)) {
			userService.delete(id);
			model.addAttribute("msg", "회원탈퇴가 정상적으로 되었습니다");
			model.addAttribute("url", "/?signout");
		} else {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("url", "/");
		}
		return "/result";
	}
	
	@RequestMapping(value = "/manage", method = RequestMethod.GET)
	public String manage(@RequestParam(defaultValue = "1") String page,
			Model model, @AuthenticationPrincipal User user) {
		int npage = 0;
		try {
			npage = Integer.parseInt(page);
		} catch (Exception e) {
		}
		int totalPage = Pager.getTotalPage(userService.userTotal());
		if (npage >= 1 && npage <= totalPage) {
			model.addAttribute("page", userService.getPage(npage));
			model.addAttribute("userList", userService.getUserList(npage));
			return "/user/manage/manage";
		}else {
			return "/board/notPage";
		}
	}
	
	@RequestMapping(value="/user/manage/view",method=RequestMethod.GET)
	public String manageView(Model model,@ModelAttribute User user) {
		model.addAttribute("user",user);
		return "user/manage/view";
	}
	
	@RequestMapping(value="/user/manage/update",method=RequestMethod.GET)
	public String manageUpdate(@AuthenticationPrincipal User user,@RequestParam String id,
			@RequestParam String password, @RequestParam String nickname,@RequestParam String image,
			@RequestParam String myinfo,Model model) {
			user.setPassword(password);
			user.setNickname(nickname);
			user.setImage(image);
			user.setMyinfo(myinfo);
			userService.update(user);
			model.addAttribute("msg","수정완료(매니저권한)");
			model.addAttribute("url","/user/manage/view");
			return "/result";
	}
	
	@RequestMapping(value="/user/manage/delete",method=RequestMethod.GET)
	public String manageDelete(@AuthenticationPrincipal User user,@RequestParam String id,Model model) {
		userService.delete(id);
		model.addAttribute("msg","회원탈퇴가 정상적으로 되었습니다");
		model.addAttribute("url","/manage");
		return "/result";
	}
}
