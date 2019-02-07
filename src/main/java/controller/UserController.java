package controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
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
import service.BoardService;
import service.FileService;
import service.UserService;
import util.Pager;
import util.VerifyRecaptcha;

@Controller
public class UserController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private BoardService boardService;
	
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
		//System.out.println(response);
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
	public String getMypage(@AuthenticationPrincipal User user,
			@ModelAttribute Board board,@RequestParam(defaultValue = "1") String page,
			Model model) {
		//새로 업데이트된 유저값 받아오기..
		model.addAttribute("user",new User());
		try {
			model.addAttribute("user",userService.selectOneById(user.getId()));
		}catch(Exception e) {
			model.addAttribute("msg","일시적인 오류입니다. 다시 로그인해주세요");
			model.addAttribute("url","/?signout");
			return "/result";
		}
		int npage = 0;
		int totalPage = Pager.getMyTotalPage(boardService.myBoardTotal(user.getId()));
		npage = Integer.parseInt(page);
		if (npage >= 1 && npage <= totalPage) {
			model.addAttribute("myBoardPage", boardService.getMyBoardPage(user.getId(),npage));
			model.addAttribute("myBoardList", boardService.getMyBoardList(user.getId(),npage));
		}else {
			return "/board/notPage";
		}
		return "/user/mypage";
		
	}
	
	@RequestMapping(value = "/user/mypage", method = RequestMethod.POST)
	public String postMypage(@AuthenticationPrincipal User user,
			@RequestParam String id, @RequestParam String password, Model model) {
		System.out.println(user.getPassword());
		System.out.println(password);
		if (user.getId().equals(id) && user.getPassword().equals(password)) {
			model.addAttribute("user",userService.selectOneById(user.getId()));
			return "/user/update";
		}
		model.addAttribute("msg","비밀번호가 틀립니다");
		model.addAttribute("url","/user/mypage");
		return "/result";
	}

	@RequestMapping(value = "/user/checkPassword", method = RequestMethod.POST)
	@ResponseBody
	public String checkPassword(@AuthenticationPrincipal User user,
			@RequestParam String id, @RequestParam String password, Model model) {
		if (user.getId().equals(id) && user.getPassword().equals(password)) {
			System.out.println(password);
			System.out.println(user.getPassword());
			return "correct";
		}
		model.addAttribute("msg","비밀번호가 틀립니다");
		model.addAttribute("url","/user/mypage");
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
	public String update(@AuthenticationPrincipal User user,
				@RequestParam String id,@RequestParam String password,
				Model model) {
		if (user.getId().equals(id)) {
			model.addAttribute("user",userService.selectOneById(user.getId()));
			return "/user/update";
		} else {
			model.addAttribute("msg", "잘못된 요청입니다");
			model.addAttribute("url", "/main");
			return "/result";
		}
	}
	
	
	@RequestMapping(value="/user/update",method=RequestMethod.POST)
	public String updatePost(@ModelAttribute User user,
			@RequestParam String id, Model model) {
		if (user.getId().equals(id)) {
			String path = session.getServletContext().getRealPath("/WEB-INF/upload/image");
			try {
				user.setImage(fileService.saveFile(path, user.getImage_file()));
			} catch (InadequateFileExtException e) {
				long time = System.currentTimeMillis();
				SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
				String str = dayTime.format(new Date(time));

				model.addAttribute("msg", "JSP, ASP, PHP 파일은 업로드할 수 없습니다.");
				model.addAttribute("url","/user/mypage");
				return "result";
			} catch (NullPointerException e) {
				model.addAttribute("msg","이미지 업로드에 실패하였습니다. 다시 수정해주세요");
				model.addAttribute("url","/user/mypage");
				return "/result";
			}
			System.out.println(user.getImage());
			if(user.getImage().equals("no_file")) {
				user.setImage(null);
			}
				userService.update(user);
				model.addAttribute("msg","수정이 완료되었습니다. 다시 로그인해주세요");
				model.addAttribute("url","/main");
				
		} else {
			model.addAttribute("msg", "잘못된 요청입니다");
			model.addAttribute("url", "/");
		}
		return "/result";
	}
	
	@RequestMapping(value="/user/delete",method=RequestMethod.GET)
	public String delete(@AuthenticationPrincipal User user, @RequestParam String id, Model model) {
		if(user.getId().equals(id)) {
			userService.delete(id);
			model.addAttribute("msg", "회원탈퇴가 정상적으로 되었습니다");
			model.addAttribute("url", "/?signout");
		}else {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("url", "/");
		}
		return "/result";
	}
	
	@RequestMapping(value="/manage/delete",method=RequestMethod.GET)
	public String manageChange(@ModelAttribute User user, @RequestParam String id, Model model) {
		if(user.getId().equals(id)) {
			userService.manageDelete(id);
			model.addAttribute("msg", "이제 일반회원입니다. 회원탈퇴도 가능합니다.다시 로그인해주세요");
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
	
	@RequestMapping(value="/user/manage/update",method=RequestMethod.POST)
	public String manageUpdate(@ModelAttribute User user, Model model) {
		String path = session.getServletContext().getRealPath("/WEB-INF/upload/image");
		try {
			user.setImage(fileService.saveImage(path, user.getImage_file()));
		} catch (InadequateFileExtException e) {
			long time = System.currentTimeMillis();
			SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
			String str = dayTime.format(new Date(time));

			model.addAttribute("msg", "JSP, ASP, PHP 파일은 업로드할 수 없습니다.");
			model.addAttribute("url","/user/manage/view");
			return "result";
		}
		if(user.getImage().equals("no_file")) {
			user.setImage(null);
		}
		try {
			userService.manageUpdate(user);
		}catch(Exception e) {
			model.addAttribute("msg","이 페이지에서는 관리자는 수정할 수 없습니다. 마이페이지를 이용해주세요");
			model.addAttribute("url","/user/mypage");
			return "/result";
		}
		model.addAttribute("msg","수정완료(매니저권한)");
		model.addAttribute("url","/manage");
		return "/result";
	}
	
	@RequestMapping(value="/user/manage/delete",method=RequestMethod.GET)
	public String manageDelete(@AuthenticationPrincipal User user,
			@RequestParam String id,Model model) {
		try {
			userService.delete(id);
		}catch(Exception e) {
			model.addAttribute("msg","이 페이지에서는 관리자는 탈퇴할 수 없습니다. 마이페이지를 이용해주세요");
			model.addAttribute("url","/user/mypage");
			return "/result";
		}
			model.addAttribute("msg","회원탈퇴가 정상적으로 되었습니다");
			model.addAttribute("url","/manage");
			
		return "/result";
		
	}
	
	@RequestMapping(value = "/manage/user/list", method = RequestMethod.GET)
	public String userSearch(@RequestParam(required = false) String search,
			Model model) {
		List<User> userSearchList = userService.userSearchList(search);
		model.addAttribute("userList", userSearchList);
		if (search != null) {
			model.addAttribute("search", search);
		}
		return "/user/manage/manage";
	}
	
}
