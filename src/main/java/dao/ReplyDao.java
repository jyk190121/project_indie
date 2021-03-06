package dao;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import domain.Reply;

@Repository
public class ReplyDao {

	@Autowired
	private SqlSession session;

	public void insert(Reply reply) {
		session.insert("reply.insert", reply);

	}

	public void insertRereply(Reply reply) {
		session.insert("reply.insertRereply", reply);
	}

	public Reply selectOne(int id) {
		return session.selectOne("reply.selectOne", id);
	}

	public int selectBrotherStep(Reply parentReply) {

		return session.selectOne("reply.brotherStep", parentReply);
	}

	public void pushReply(Reply reply) {
		session.update("reply.pushReply", reply);
	}

	public int maxStep(int board_id, String type) {
		Map<String, Object> map = new HashMap<>();
		map.put("idx", board_id);
		map.put("type", type);
		return session.selectOne("reply.maxStep", map);
	}
}
