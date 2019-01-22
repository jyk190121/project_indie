package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import domain.Board;

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
}
