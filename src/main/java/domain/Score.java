package domain;

public class Score {

	private int id, game_id, score;
	private String users_id, play_timestamp;
	private User user;
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getGame_id() {
		return game_id;
	}
	public void setGame_id(int game_id) {
		this.game_id = game_id;
	}
	public int getScore() {
		return score;
	}
	public void setScore(int score) {
		this.score = score;
	}
	public String getUsers_id() {
		return users_id;
	}
	public void setUsers_id(String users_id) {
		this.users_id = users_id;
	}
	public String getPlay_timestamp() {
		return play_timestamp;
	}
	public void setPlay_timestamp(String play_timestamp) {
		this.play_timestamp = play_timestamp;
	}

}
