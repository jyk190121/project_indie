package domain;

import java.util.List;

import javax.validation.constraints.NotNull;

public class Board {
	private int id,hit,reply_count;
	private List<Reply> replyList;
	private String writer,write_date,ip,attach_file,type;
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@NotNull(message="제목을 입력해주세요")
	private String title;
	@NotNull(message="내용을 입력해 주세요")
	private String content;
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

	public int getHit() {
		return hit;
	}

	public void setHit(int hit) {
		this.hit = hit;
	}

	public int getReply_count() {
		return reply_count;
	}

	public void setReply_count(int reply_count) {
		this.reply_count = reply_count;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public String getAttach_file() {
		return attach_file;
	}

	public void setAttach_file(String attach_file) {
		this.attach_file = attach_file;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public List<Reply> getReplyList() {
		return replyList;
	}

	public void setReplyList(List<Reply> replyList) {
		this.replyList = replyList;
	}

/*	@Override
	public String toString() {
		return "Board [id=" + id + ", hit=" + hit + ", reply_count=" + reply_count + ", replyList=" + replyList
				+ ", writer=" + writer + ", write_date=" + write_date + ", ip=" + ip + ", attach_file=" + attach_file
				+ ", title=" + title + ", content=" + content + "]";
	}*/
	
	
	
}
