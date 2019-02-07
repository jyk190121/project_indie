package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ReplyDao;
import domain.Reply;

@Service
public class ReplyService {

	@Autowired
	private ReplyDao replyDao;

	public void add(Reply reply) {
		replyDao.insert(reply);
	}

	public void addRereply(Reply reply) {
		// depth계산
		Reply parentReply = replyDao.selectOne(reply.getRef());

		reply.setDepth(parentReply.getDepth() + 1);

		// step계산
		int step = 0;

		// 부모의 형제를 찾거나 그러지 못할경우 부모의 부모..
		// 루트댓글일때까지 찾는다
		while (true) {
			step = replyDao.selectBrotherStep(parentReply);

			if (step != 0) {
				// 찾았을 경우
				reply.setStep(step);
				// 해당 스탭보다 크커나 같은 스탭을 가진 댓글들의
				// 스탭을 1씩 증가
				replyDao.pushReply(reply);
				break;
			}

			if (parentReply.getRef() == 0) {
				step = replyDao.maxStep(reply.getIdx(), reply.getType());

				reply.setStep(step);
				break;
			}

			parentReply = replyDao.selectOne(parentReply.getRef());
		}

		replyDao.insertRereply(reply);
	}
}
