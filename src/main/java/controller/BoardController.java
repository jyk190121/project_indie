package controller;

import javax.servlet.http.HttpServletRequest;
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

import domain.Board;
import domain.User;
import service.BoardService;
import util.Pager;
import util.Role;

@Controller
public class BoardController {

	@Autowired
	BoardService boardService;

	@Autowired
	private HttpServletRequest httpRequest;

	@RequestMapping(value = "/board/list", method = RequestMethod.GET)
	public String list(@RequestParam(defaultValue = "1") String page, Model model, @ModelAttribute Board board,
			@AuthenticationPrincipal User user) {
		int npage = 0;
		try {
			npage = Integer.parseInt(page);
		} catch (Exception e) {
		}
		int totalPage = Pager.getTotalPage(boardService.boardTotal());
		if (npage >= 1 && npage <= totalPage) {
			model.addAttribute("page", boardService.getPage(npage));
			model.addAttribute("boardList", boardService.getBoardList(npage));
			return "/board/list";
		}
		return "/board/notPage";

	}

	@RequestMapping(value = "/board/insert", method = RequestMethod.GET)
	public String addGet(Model model, @RequestParam String type) {
		Board board = new Board();
		board.setType(type);
		model.addAttribute("board", board);
		return "/board/insert";
	}

	@RequestMapping(value = "/board/insert", method = RequestMethod.POST)
	public String addPost(@ModelAttribute Board board, BindingResult bindingResult,
			@AuthenticationPrincipal User user) {
		if (bindingResult.hasErrors()) {
			return "/board/insert";
		}
		if (!httpRequest.isUserInRole("ROLE_ADMIN") && board.getType().equals("notice")) {
			return "/board/insert";
		}
		
		board.setWriter(user.getId());
		board.setIp(httpRequest.getRemoteAddr());
		/* System.out.println(board); */
		boardService.add(board);
		return "redirect:/board/list";
	}

	@RequestMapping(value = "/board/view", method = RequestMethod.GET)
	public String view(@RequestParam int id, Model model) {
		// 조회수 순서변경(화면 뿌려주기전에 조회수부터 올림)
		boardService.hitUp(id);
		model.addAttribute("board", boardService.getBoardSelect(id));
		return "/board/view";
	}

	@RequestMapping(value = "/board/delete", method = RequestMethod.GET)
	public String delete(@RequestParam int id, Model model, @AuthenticationPrincipal User user) {
		Board board = boardService.getBoardSelect(id);

		if (user.getId().equals(board.getWriter()) || Role.hasRole(user, "ROLE_ADMIN")) {
			boardService.delete(id);
			model.addAttribute("msg", "게시물이 삭제되었습니다");
			model.addAttribute("url", "/board/list");
		} else {
			model.addAttribute("msg", "잘못된 요청입니다 : 5650");
			model.addAttribute("url", "/board/view?id=" + board.getId());
		}
		return "/result";
	}

	@RequestMapping(value = "/board/update", method = RequestMethod.GET)
	public String getUpdate(@RequestParam int id, Model model, @AuthenticationPrincipal User user) {
		Board board = boardService.getBoardSelect(id);
		if (user.getId().equals(board.getWriter()) || Role.hasRole(user, "ROLE_ADMIN")) {
			model.addAttribute("board", board);
			model.addAttribute("msg", "게시물이 수정되었습니다");
			return "/board/update";
		} else {
			model.addAttribute("msg", "잘못된 요청입니다");
			model.addAttribute("url", "/board/list");
		}
		return "/result";
	}

	@RequestMapping(value = "/board/update", method = RequestMethod.POST)
	public String postUpdate(@ModelAttribute @Valid Board board, BindingResult bindingResult, Model model,
			@AuthenticationPrincipal User user) {
		Board existBoard = boardService.getBoardSelect(board.getId());
		if (user.getId().equals(existBoard.getWriter()) || Role.hasRole(user, "ROLE_ADMIN")) {
			if (bindingResult.hasErrors()) {
				return "/board/update";
			}
			boardService.update(board);
			return "redirect: /board/view?id=" + board.getId();
		} else {
			model.addAttribute("msg", "잘못된 요청입니다");
			model.addAttribute("url", "/board/list");
			return "/result";
		}

	}

}
