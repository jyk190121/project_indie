package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import domain.Reply;
import domain.User;
import service.ReplyService;

@Controller
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	
	@RequestMapping(value="/reply/insert", 
					method=RequestMethod.POST)
	public String reply(@ModelAttribute Reply reply,
						@AuthenticationPrincipal User user) {
		reply.setWriter(user.getId());
		replyService.add(reply);
		return "redirect:/board/view?id="+reply.getBoard_id();
	}
	
	@RequestMapping(value="/reply/rereply", 
					method=RequestMethod.POST)
	public String reReply(@ModelAttribute Reply reply,
						  @AuthenticationPrincipal User user) {
		reply.setWriter(user.getId());
		replyService.addRereply(reply);
		return "redirect:/board/view?id="+reply.getBoard_id();
	}
}






