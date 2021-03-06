package service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.GameDao;
import domain.Game;
import domain.GameLike;
import domain.Score;
import domain.User;

@Service
public class GameService {

	@Autowired
	private GameDao gameDao;

	public List<Game> gameList(int count) {
		return gameDao.gameList(count);
	}
	
	public List<Game> gameList(Map<String,String> map) {
		return gameDao.gameList(map);
	}

	public List<Game> hotGameList() {
		return gameDao.hotGameList();
	}

	private Map<String, Map<Integer, Set<Integer>>> hotGameScoreToMap(){
		List<Score> hotGameScoreList = gameDao.hotGameScoreList();
		Map<String, Map<Integer, Set<Integer>>> map = new HashMap<>();
		for (Score score : hotGameScoreList) {
			if (map.get(score.getUsers_id()) == null) {
				map.put(score.getUsers_id(), new HashMap<Integer, Set<Integer>>());
			}
			if (map.get(score.getUsers_id()).get(score.getGame_id()) == null) {
				map.get(score.getUsers_id()).put(score.getGame_id(), new HashSet<Integer>());
			}
			map.get(score.getUsers_id()).get(score.getGame_id()).add(score.getScore());
		}
		return map;
	}
	
	public List<User> rankerList(int count) {
		return gameDao.rankerList(count);
	}

	public List<Score> highScoreList() {
		Map<String, Map<Integer, Set<Integer>>> map = hotGameScoreToMap();
		
		List<Score> highScoreList = new ArrayList<>();
		for (String key : map.keySet()) {
			for (int key2 : map.get(key).keySet()) {
				Score score = new Score();
				score.setUsers_id(key);
				score.setGame_id(key2);
				score.setScore(0);
				for (int num : map.get(key).get(key2)) {
					if (score.getScore() < num) {
						score.setScore(num);
					}
				}
				highScoreList.add(score);
			}
		}
		return highScoreList;
	}

	public void insertGame(Game game) {
		gameDao.insertGame(game);
	}
	
	public Game selectOne(String id) {
		return gameDao.selectOne(id);
	}

	public int getNextId() {
		return gameDao.getNextId();
	}
	
	public void updateEvalCount(String game_id, String type, int count) {
		Map<String, Object> map = new HashMap<>();
		map.put("game_id", game_id);
		map.put("type", type);
		map.put("count", count);
		gameDao.updateEvalCount(map);
	}
	
	
	//gameLike

	public GameLike selectGameLike(GameLike input) {
		return gameDao.selectGameLike(input);
	}
	
	public boolean isEvaluationExisting(GameLike input) {
		if(gameDao.selectGameLike(input) == null) {
			return false;
		}else {
			return true;
		}
	}

	public void updateGameLike(GameLike input) {
		gameDao.updateGameLike(input);
	}

	public void insertGameLike(GameLike input) {
		gameDao.insertGameLike(input);
	}

	public void updateReplyCount(int idx) {
		gameDao.updateReplyCount(idx);		
	}

	public List<Game> gameMyList(int i, int id) {
		Map<String, Integer> map = new HashMap<>();
		map.put("id", id);
		map.put("count", i);
		List<Game> gameMyList = gameDao.gameMyList(map);
		return gameMyList;
	}

}
