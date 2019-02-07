package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import domain.Game;
import domain.GameLike;
import domain.Score;
import domain.User;

@Repository
public class GameDao {

	@Autowired
	private SqlSession session;

	public List<Game> gameList(int count) {
		return session.selectList("game.selectListAsCount", count);
	}

	public List<Game> gameList(Map<String,String> map) {
		return session.selectList("game.selectList", map);
	}

	public List<Game> hotGameList() {
		return session.selectList("game.hotGameList");
	}

	public List<Score> hotGameScoreList() {
		return session.selectList("game.hotGameScoreList");
	}

	public List<User> rankerList(int count) {
		return session.selectList("game.rankerList", count);
	}

	public void insertGame(Game game) {
		session.insert("game.insertGame", game);
	}

	public Game selectOne(String id) {
		return session.selectOne("game.selectOneById", id);
	}

	public int getNextId() {
		return session.selectOne("game.getNextId");
	}

	public GameLike selectGameLike(GameLike input) {
		return session.selectOne("game.selectGameLike", input);
	}

	public void updateGameLike(GameLike input) {
		session.update("game.updateGameLike",input);
	}

	public void insertGameLike(GameLike input) {
		session.insert("game.insertGameLike", input);
	}

	public void updateEvalCount(Map<String, Object> map) {
		session.update("game.updateEvalCount", map);
	}

	public void updateReplyCount(int idx) {
		session.update("game.reply_count",idx);
	}
	
}
