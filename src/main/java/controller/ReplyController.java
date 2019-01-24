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
import service.ReplyService;

@Controller
public class ReplyController {
	
	@Autowired
	private ReplyService replyService;
	@Autowired
	private BoardService boardService;
	
	@RequestMapping(value="/reply/insert", 
					method=RequestMethod.POST)
	public String reply(@ModelAttribute Reply reply,
						@AuthenticationPrincipal User user) {
		reply.setWriter(user.getId());
		/*System.out.println(reply);*/
		replyService.add(reply);
		if(reply.getType().equals("board")) {
			boardService.reply_count(reply.getIdx());
		}else if(reply.getType().equals("game")) {
		}
		return "redirect:/board/view?id="+reply.getIdx();
	}
	
	@RequestMapping(value="/reply/rereply", 
					method=RequestMethod.POST)
	public String reReply(@ModelAttribute Reply reply,
						  @AuthenticationPrincipal User user) {
		reply.setWriter(user.getId());
		reply.setType("board");
		replyService.addRereply(reply);
		return "redirect:/board/view?id="+reply.getIdx();
	}
}






