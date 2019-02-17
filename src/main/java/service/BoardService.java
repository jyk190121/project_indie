package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.BoardDao;
import dao.UserDao;
import domain.Board;
import domain.User;
import util.Pager;

@Service
public class BoardService {

	@Autowired
	private BoardDao boardDao;
	
	public String getPage(int page) {
		int total = boardDao.boardTotal();
		return Pager.paging(page,total);
	}
	
	public String getMyBoardPage(String id,int page) {
		int total = boardDao.myBoardTotal(id);
		return Pager.myBoardPaging(page, total);
	}
	
	public List<Board> getBoardList(int page) {
		int start = (page -1) * Pager.BOARDS + 1;
		int end = start + Pager.BOARDS - 1;
		
		Map<String, Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		List<Board> boardList = boardDao.selectList(map);
		return boardList;
	}
	
	public List<Board> getMyBoardList(String id,int page) {
		int start = (page -1) * 5 + 1;
		int end = start + 4;
		
		Map<String, Object> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		map.put("user_id", id);
		List<Board> boardList = boardDao.myBoardList(map);
		return boardList;
	}
	
	public void add(Board board) {
		boardDao.insert(board);
	}

	public void delete(int id) {
		boardDao.delete(id);
	}

	public Board getBoardSelect(int id) {
		return boardDao.boardSelect(id);
	}

	public int boardTotal() {
		return boardDao.boardTotal();
	}
	
	public void update(Board board) {
		boardDao.update(board);
	}
	
	public void hitUp(int id) {
		boardDao.hitUp(id);
	}

	public int updateReplyCount(int id) {
		return boardDao.updateReplyCount(id);
	}

	public int myBoardTotal(String id) {
		return boardDao.myBoardTotal(id);
	}

	public List<Board> getNormalBoardList(int cnt) {
		return boardDao.getNormalBoardList(cnt);
	}

	public List<Board> getNoticeBoardList(int cnt) {
		return boardDao.getNoticeBoardList(cnt);
	}

}
