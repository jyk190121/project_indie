package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import dao.UserDao;
import domain.Board;
import domain.User;

@Service
public class UserService implements UserDetailsService{

	@Autowired
	private UserDao userDao;
	
	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		User user = userDao.selectOne(id);
		if(user == null) {
			throw new UsernameNotFoundException("존재하지 않는 유저");
		}
		return user;
	}

	public int nicknameDualCheck(String input) {
		return userDao.nicknameDualCheck(input);
	}

	public User userSelect(String id) {
		return userDao.userSelect(id);
	}

	public void update(User user) {
		userDao.update(user);
	}

	public void delete(String id) {
		userDao.delete(id);
	}

}
