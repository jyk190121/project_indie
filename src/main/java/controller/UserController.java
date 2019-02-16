package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
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
import domain.Game;
import domain.User;
import exception.InadequateFileExtException;
import service.BoardService;
import service.FileService;
import service.GameService;
import service.UserService;
import util.Clock;
import util.Pager;
import util.VerifyRecaptcha;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private BoardService boardService;

	@Autowired
	private GameService gameService;

	@Autowired
	private FileService fileService;

	@Autowired
	private HttpSession session;

	@RequestMapping(value = { "/", "/main" }, method = RequestMethod.GET)
	public String main(@AuthenticationPrincipal User user, Model model) {
		if(user == null) {
			model.addAttribute("user",user);
		}else {
			model.addAttribute("user", userService.selectOne(user.getId()));
		}
		return "main";
	}

	// 회원가입

	@RequestMapping(value = "/user/join", method = RequestMethod.GET)
	public String joinGet(Model model) {
		model.addAttribute(new User());
		return "user/join";
	}

	@RequestMapping(value = "/user/join", method = RequestMethod.POST)
	public String joinPost(@ModelAttribute @Valid User user, BindingResult bindingResult,
			@RequestParam(value = "g-recaptcha-response") String response, Model model) {
		// System.out.println(response);
		try {
			if (!VerifyRecaptcha.verify(response)) {
				return "/user/join";
			}
		} catch (IOException e1) {
			e1.printStackTrace();
			return "/user/join";
		}
		if (bindingResult.hasErrors()) {
			return "/user/join";
		}
		if (userService.selectOne(user.getId()) != null) {
			return "/user/join";
		}
		if (!((String) session.getAttribute("email")).equals(user.getEmail())) {
			return "/user/join";
		}
		String path = session.getServletContext().getRealPath("/WEB-INF/upload/image");
		String filename;
		try {
			filename = fileService.saveFile(path, user.getImage_file());
		} catch (InadequateFileExtException e) {
			System.out.println(Clock.getCurrentTime() + "사용자가 jsp나 asp, php 파일의 업로드를 시도함.");
			model.addAttribute("msg", "JSP, ASP, PHP 파일은 업로드할 수 없습니다.");
			model.addAttribute("url", "/game/insert");
			return "result";
		}
		if (filename.equals("no_file")) {
			user.setImage("default.png");
		} else if (!filename.equals("no_file")) {
			user.setImage(filename);
		}
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

	// 마이페이지

	@RequestMapping(value = "/user/mypage", method = RequestMethod.GET)
	public String getMypage(@AuthenticationPrincipal User user, @ModelAttribute Board board,
			@RequestParam(defaultValue = "1") String page, Model model) {
		// 새로 업데이트된 유저값 받아오기..
		model.addAttribute("user", userService.selectOneById(user.getId()));
		int npage = 0;
		int totalPage = Pager.getMyTotalPage(boardService.myBoardTotal(user.getId()));
		if(totalPage == 0) {
			return "/user/mypage";
		}
		npage = Integer.parseInt(page);
		if (npage >= 1 && npage <= totalPage) {
			model.addAttribute("myBoardPage", boardService.getMyBoardPage(user.getId(), npage));
			model.addAttribute("myBoardList", boardService.getMyBoardList(user.getId(), npage));
		} else {
			return "/board/notPage";
		}
		return "/user/mypage";
	}

	@RequestMapping(value = "/user/mypage", method = RequestMethod.POST)
	public String postMypage(@AuthenticationPrincipal User user, @RequestParam String id, @RequestParam String password,
			Model model) {
		User currentUser = userService.selectOneById(user.getId());
		if (user.getId().equals(id) && currentUser.getPassword().equals(password)) {
			model.addAttribute("user", currentUser);
			return "/user/update";
		}
		model.addAttribute("msg", "비밀번호가 틀립니다");
		model.addAttribute("url", "/user/mypage");
		return "/result";
	}

	/*
	 * @RequestMapping(value = "/user/update", method = RequestMethod.GET) public
	 * String update(@AuthenticationPrincipal User user, @RequestParam String
	 * id, @RequestParam String password, Model model) { System.out.println("dd");
	 * if (user.getId().equals(id)) { return "/user/update"; } else {
	 * model.addAttribute("msg", "잘못된 요청입니다"); model.addAttribute("url", "/main");
	 * return "/result"; } }
	 */

	@RequestMapping(value = "/user/update", method = RequestMethod.POST)
	public String updatePost(@ModelAttribute User user, @AuthenticationPrincipal User savedUser, Model model) {
		System.out.println(user);
		user.setId(savedUser.getId());
		String path = session.getServletContext().getRealPath("/WEB-INF/upload/image");
		try {
			user.setImage(fileService.saveFile(path, user.getImage_file()));
		} catch (InadequateFileExtException e) {
			model.addAttribute("msg", "이미지 파일만 업로드 가능합니다.");
			model.addAttribute("url", "/user/mypage");
			return "/result";
		} catch (NullPointerException e) {
			model.addAttribute("msg", "이미지 업로드에 실패하였습니다. 다시 수정해주세요");
			model.addAttribute("url", "/user/mypage");
			return "/result";
		}
		if (user.getImage().equals("no_file")) {
			user.setImage(null);
		}
		userService.update(user);
		model.addAttribute("msg", "수정이 완료되었습니다.");
		model.addAttribute("url", "/user/mypage");
		return "/result";
	}

	@RequestMapping(value = "/user/delete", method = RequestMethod.POST)
	public String delete(@AuthenticationPrincipal User user, @ModelAttribute User inputUser, Model model) {
		if (user.getId().equals(inputUser.getId()) && user.getPassword().equals(inputUser.getPassword())) {
			userService.delete(user.getId());
			model.addAttribute("msg", "회원탈퇴가 정상적으로 되었습니다");
			return "user/signout";
		} else {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("url", "/");
		}
		return "/result";
	}
	
	
	//프로필
	
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public String profile(Model model,@RequestParam int writer_id) {
		model.addAttribute("user", userService.selectOnebyWriter(writer_id));
		List<Game> gameList = gameService.gameMyList(20, writer_id);
		model.addAttribute("gameList", gameList);
		return "/user/profile";
	}

	
	//랭킹
	
	@RequestMapping(value = "/ranking", method = RequestMethod.GET)
	public String ranking(@RequestParam(defaultValue="1") String page,
				@AuthenticationPrincipal User user,@RequestParam(required = false) String search, Model model) {
		Map<String, String> map = new HashMap<>();
		map.put("search", search);
		map.put("type", "nickname");
		map.put("page", page);
		model.addAttribute("userList", userService.userList(map));
		return "/ranking/ranking";
	}
	
	@RequestMapping(value = "/ranking", method = RequestMethod.POST)
	@ResponseBody
	public String rankingPost(@RequestParam String page,
				@AuthenticationPrincipal User user, @RequestParam(required = false) String search, Model model) {
		Map<String, String> map = new HashMap<>();
		map.put("search", search);
		map.put("type", "nickname");
		map.put("page", page);
		List<User> userList = userService.userList(map);
		String tabletd="";
		for(User getuser : userList) {
			tabletd += ("<tr><td>"+getuser.getId()+"</td><tr>");
		}
		System.out.println("table : ");
		System.out.println(tabletd);
		return tabletd;
	}
	
}
