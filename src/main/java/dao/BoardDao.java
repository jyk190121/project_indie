package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import domain.Board;
import domain.User;

@Repository
public class BoardDao {

	@Autowired
	private SqlSession session;
	
	public int boardTotal() {
		return session.selectOne("board.boardTotal");
	}
	
	public List<Board> selectList(Map<String, Integer> map) {
		return session.selectList("board.selectList",map);
	}
	
	public void insert(Board board) {
		session.insert("board.insert",board);
	}

	public void delete(int id) {
		session.delete("board.delete",id);
	}

	public Board boardSelect(int id) {
		return session.selectOne("board.boardSelect",id);
	}
	
	public void update(Board board) {
		session.update("board.update",board);
	}
	
	public void hitUp(int id) {
		session.update("board.hitUp", id);
	}

	public int updateReplyCount(int id) {
		return session.update("board.reply_count",id);
	}

	public List<Board> myBoardList(Map<String, Object> map) {
		return session.selectList("board.myBoardList",map);
	}

	public int myBoardTotal(String id) {
		return session.selectOne("board.myBoardTotal",id);
	}

	public List<Board> getNormalBoardList(int cnt) {
		return session.selectList("board.getNormalBoardList", cnt);
	}

	public List<Board> getNoticeBoardList(int cnt) {
		return session.selectList("board.getNoticeBoardList", cnt);
	}

}
