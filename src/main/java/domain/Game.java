package domain;

import java.util.List;

import org.hibernate.validator.constraints.NotBlank;
import org.springframework.web.multipart.MultipartFile;

public class Game {

	private int id, hit, likes, unlikes, reply_count;
	@NotBlank(message="이름을 지어라")
	private String name;
	private String type;
	private String src;
	@NotBlank(message="설명해라 설명")
	private String info;
	private String image;
	private User user;
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	private String users_id, regist_date, etc_info;
	
	private MultipartFile image_file;
	private MultipartFile game_file;
	
	private List<Reply> replyList;
	
	public List<Reply> getReplyList() {
		return replyList;
	}
	public void setReplyList(List<Reply> replyList) {
		this.replyList = replyList;
	}
	
	public int getEvalCount(String eval) {
		if(eval.equals("like")) {
			return getLikes();
		}else if(eval.equals("unlike")){
			return getUnlikes();
		}
		return -1;
	}
	
	public MultipartFile getImage_file() {
		return image_file;
	}
	public void setImage_file(MultipartFile image_file) {
		this.image_file = image_file;
	}
	public MultipartFile getGame_file() {
		return game_file;
	}
	public void setGame_file(MultipartFile game_file) {
		this.game_file = game_file;
	}
	public String getEtc_info() {
		return etc_info;
	}
	public void setEtc_info(String etc_info) {
		this.etc_info = etc_info;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getLikes() {
		return likes;
	}
	public void setLikes(int likes) {
		this.likes = likes;
	}
	public int getUnlikes() {
		return unlikes;
	}
	public void setUnlikes(int unlikes) {
		this.unlikes = unlikes;
	}
	public int getReply_count() {
		return reply_count;
	}
	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSrc() {
		return src;
	}
	public void setSrc(String src) {
		this.src = src;
	}
	public String getInfo() {
		return info;
	}
	public void setInfo(String info) {
		this.info = info;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getUsers_id() {
		return users_id;
	}
	public void setUsers_id(String users_id) {
		this.users_id = users_id;
	}
	public String getRegist_date() {
		return regist_date;
	}
	public void setRegist_date(String regist_date) {
		this.regist_date = regist_date;
	}
	
}
