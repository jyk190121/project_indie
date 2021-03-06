package controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@RequestMapping(value = { "/", "/main" }, method = RequestMethod.GET)
	public String main(@AuthenticationPrincipal User user, @RequestParam(required=false ,name="googleInfo") Map<String,String> googleInfo, Model model) {
		if(user == null) {
			model.addAttribute("user",user);
		}else {
			model.addAttribute("user", userService.selectOne(user.getId()));
		}
		List<Game> hotGameList = gameService.hotGameList();
		model.addAttribute("hotGameList", hotGameList);	
		Map<String, String> map = new HashMap<>();
		map.put("page", "1");
		model.addAttribute("userList", userService.userList(map));
		model.addAttribute("normalBoardList", boardService.getNormalBoardList(10));
		model.addAttribute("noticeBoardList", boardService.getNoticeBoardList(10));
		model.addAttribute("gameList", gameService.gameList(8));
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
		if (user.getId().equals(id) && passwordEncoder.matches(password, currentUser.getPassword())) {
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
		user = userService.selectOneById(user.getId());
		if (user.getId().equals(inputUser.getId()) && passwordEncoder.matches(inputUser.getPassword(), user.getPassword())) {
			userService.delete(user.getId());
			model.addAttribute("msg", "회원탈퇴가 정상적으로 되었습니다");
			return "user/signout";
		} else {
			model.addAttribute("msg", "비밀번호가 틀립니다");
			model.addAttribute("url", "/user/mypage");
		}
		return "/result";
	}
	
	
	//프로필
	
	@RequestMapping(value = "/profile", method = RequestMethod.GET)
	public String profile(Model model,@RequestParam int writer_id,
			@ModelAttribute Board board,
			@RequestParam(defaultValue = "1") String page) {
		model.addAttribute("user", userService.selectOnebyWriter_id(writer_id));
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
	
	@RequestMapping(value = "/ranking", method = RequestMethod.POST, produces="text/plain;charset=UTF-8")
	@ResponseBody
	public String rankingPost(@RequestParam String page,
				@AuthenticationPrincipal User user, @RequestParam(required = false) String search, Model model) {
		Map<String, String> map = new HashMap<>();
		map.put("search", search);
		map.put("type", "nickname");
		map.put("page", page);
		List<User> userList = userService.userList(map);
		String tabletd="";
		for(User getUser : userList) {
			tabletd += ("<tr onclick=\"javascript:userList("+getUser.getWriter_id()+");\"\r\n style=\"cursor:pointer;\">");
			tabletd += ("<td>"+getUser.getRnum()+"</td>");
			tabletd += ("<td>"+getUser.getNickname()+"</td>");
			tabletd += ("<td>"+getUser.getLev()+"</td>");
			tabletd += ("<td>"+getUser.getExp()+"</td>");
			tabletd += ("</tr>");
		}
		/*System.out.println("table : ");
		System.out.println(tabletd);*/
		return tabletd;
	}
	
	//crop image
	@RequestMapping(value="/user/cropimage", method=RequestMethod.GET)
	public String cropImage() {
		return "cropimage";
	}
	
	
	//구글계정으로 로그인
	@RequestMapping(value="/user/google/login", method=RequestMethod.POST)
	public String googleLogin(@RequestParam String email, @RequestParam String googleId, Model model, RedirectAttributes redirectAttributes) throws ServletException, IOException {
		User user = userService.selectOneByEmail(email);
		if(user == null) {
			Map<String, String> map = new HashMap<>();
			map.put("email",email);
			map.put("googleId", googleId);
			redirectAttributes.addFlashAttribute("googleInfo",map);
			return "redirect:/?googleFail";
		}else {
			model.addAttribute("id",user.getId());
			model.addAttribute("googleId", googleId);
			return "googleLogin";
		}
	}
	
	//구글계정으로 회원가입
	@RequestMapping(value="/user/google/join", method=RequestMethod.POST)
	public String googleJoinPageView(@RequestParam String email, @RequestParam String googleId, Model model) {
		model.addAttribute("email", email);
		model.addAttribute("googleId", googleId);
		return "/user/googleJoin";
	}
	
	@RequestMapping(value = "/user/google/regist", method = RequestMethod.POST)
	public String googleJoin(@RequestParam(value = "g-recaptcha-response") String response, @ModelAttribute User user, Model model) {
		try {
			if (!VerifyRecaptcha.verify(response)) {
				model.addAttribute("msg","잘못된 접근입니다");
				model.addAttribute("url","/");
				return "result";
			}
		} catch (IOException e1) {
			e1.printStackTrace();
			return "redirect:/";
		}
		if(!user.getNickname().matches("[ㄱ-ㅎ가-힣ㅏ-ㅣ0-9A-Za-z!@#*_-]{4,20}")) {
			model.addAttribute("msg","잘못된 접근입니다");
			model.addAttribute("url","/");
			return "result"; 
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
		user.setId("google_"+userService.getRandomCode(13));
		while (userService.selectOne(user.getId()) != null) {
			user.setId("google_"+userService.getRandomCode(13));
		}
		user.setPassword(user.getGoogleId());
		userService.insert(user);
		return "redirect:/?signin";
	}

}
