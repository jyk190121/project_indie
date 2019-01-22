package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import domain.Game;
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
	
}
