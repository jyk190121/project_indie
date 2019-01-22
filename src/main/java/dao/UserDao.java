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
		System.out.println(11);
		User user = session.selectOne("users.selectOne", id);
		System.out.println(user.getId());
		System.out.println();
		return session.selectOne("users.selectOne", id);
	}
	
}
