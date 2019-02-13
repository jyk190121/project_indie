package controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import domain.User;
import exception.InadequateFileExtException;
import service.FileService;
import service.UserService;

@Controller
public class ManageController {

	@Autowired
	private UserService userService;

	@Autowired
	private FileService fileService;

	@Autowired
	private HttpSession session;

	@RequestMapping(value = "/manage", method = RequestMethod.GET)
	public String manageGet(@RequestParam(required=false) String type, @RequestParam(required = false) String search,
			@AuthenticationPrincipal User user, Model model) {
		System.out.println(search);
		Map<String, String> map = new HashMap<>();
		map.put("search", search);
		if(!(type == null || type.equals("id") || type.equals("nickname"))) {
			model.addAttribute("msg", "잘못된 접근입니다");
			model.addAttribute("url", "/");
			return "result";
		}
		map.put("type", type);
		List<User> userList = userService.userList(map);
		model.addAttribute("userList", userList);
		if (search != null) {
			model.addAttribute("search", search);
		}
		return "manage/manageMain";
	}

	@RequestMapping(value = "/manage/user", method = RequestMethod.GET)
	public String manageUser(Model model, @ModelAttribute User user) {
		model.addAttribute("user", userService.selectOne(user.getId()));
		return "/manage/view";
	}

	@RequestMapping(value = "/manage/user/update", method = RequestMethod.POST)
	public String manageUpdate(@ModelAttribute User user, Model model) {
		String path = session.getServletContext().getRealPath("/WEB-INF/upload/image");
		try {
			user.setImage(fileService.saveImage(path, user.getImage_file()));
		} catch (InadequateFileExtException e) {
			long time = System.currentTimeMillis();
			SimpleDateFormat dayTime = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
			String str = dayTime.format(new Date(time));

			model.addAttribute("msg", "이미지 파일만 업로드할 수 있습니다.");
			model.addAttribute("url", "/manage");
			return "/result";
		}
		if (user.getImage().equals("no_file")) {
			user.setImage(null);
		}
		try {
			userService.manageUpdate(user);
		} catch (Exception e) {
			e.printStackTrace();
			model.addAttribute("msg", "이 페이지에서는 관리자는 수정할 수 없습니다. 마이페이지를 이용해주세요");
			model.addAttribute("url", "/user/mypage");
			return "/result";
		}
		model.addAttribute("msg", "수정완료(매니저권한)");
		model.addAttribute("url", "/manage");
		return "/result";
	}

	@RequestMapping(value = "/manage/user/delete", method = RequestMethod.GET)
	public String manageDelete(@RequestParam String id, Model model) {
		try {
			userService.delete(id);
		} catch (Exception e) {
			model.addAttribute("msg", "이 페이지에서는 관리자는 탈퇴할 수 없습니다. 마이페이지를 이용해주세요");
			model.addAttribute("url", "/user/mypage");
			return "/result";
		}
		model.addAttribute("msg", "회원탈퇴가 정상적으로 되었습니다");
		model.addAttribute("url", "/manage");

		return "/result";
	}

}
