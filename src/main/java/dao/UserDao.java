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

	public User userSelect(String id) {
		return session.selectOne("users.selectUser",id);
	}

	public void update(User user) {
		session.update("users.update",user);
	}


}
