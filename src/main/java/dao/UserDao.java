package dao;

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
}
