package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import domain.Reply;
import domain.User;
import service.BoardService;
import service.GameService;
import service.ReplyService;
import service.UserService;

@Controller
public class ReplyController {

	@Autowired
	private ReplyService replyService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private GameService gameService;
	@Autowired
	private UserService userService;

	@RequestMapping(value = "/reply/insert", method = RequestMethod.POST)
	public String reply(@ModelAttribute Reply reply, @AuthenticationPrincipal User user) {
		System.out.println("insert");
		reply.setWriter(user.getId());
		replyService.add(reply);
		if (reply.getType().equals("board")) {
			boardService.updateReplyCount(reply.getIdx());
		} else if (reply.getType().equals("game")) {
			gameService.updateReplyCount(reply.getIdx());
		}
		userService.getExp10(user.getId());
		return "redirect:/"+reply.getType()+"/view?id=" + reply.getIdx();
	}

	@RequestMapping(value = "/reply/rereply", method = RequestMethod.POST)
	public String reReply(@ModelAttribute Reply reply, @AuthenticationPrincipal User user) {
		reply.setWriter(user.getId());
		replyService.addRereply(reply);
		if (reply.getType().equals("board")) {
			boardService.updateReplyCount(reply.getIdx());
		} else if (reply.getType().equals("game")) {
			gameService.updateReplyCount(reply.getIdx());
		}
		userService.getExp10(user.getId());
		return "redirect:/"+reply.getType()+"/view?id=" + reply.getIdx();
	}
}
