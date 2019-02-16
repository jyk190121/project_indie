package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import domain.User;

@Repository
public class UserDao {

	@Autowired
	private SqlSession session;
	
	public User selectOne(String id) {
		return session.selectOne("users.selectOne", id);
	}

	public int nicknameDualCheck(String input) {
		return session.selectOne("users.nicknameDualCheck", input);
	}

	public void update(User user) {
		session.update("users.update",user);
	}

	public void delete(String id) {
		session.delete("users.delete",id);
	}

	public User selectOneByEmail(String email) {
		return session.selectOne("users.selectOneByEmail",email);
	}
	
	public User selectOneById(String id) {
		return session.selectOne("users.selectOneById",id);
	}

	public void updateEmail(User user) {
		session.update("users.updateEmail",user);
	}

	public void insert(User user) {
		session.insert("users.insert",user);
	}

	public List<User> userList(Map<String, String> map) {
		return session.selectList("users.userList",map);
	}

	public void manageUpdate(User user) {
		session.update("users.manageUpdate",user);
	}

	public void getExp(Map<String, Object> map) {
		session.update("users.getExp", map);
	}

	public void levUp(Map<String, Object> map) {
		session.update("users.levUp",map);
	}

	public int getExp(String id) {
		return session.selectOne("users.exp",id);
	}

	public User selectOnebyWriter_id(int writer_id) {
		return session.selectOne("users.selectOnebyWriter",writer_id);
	}

}
