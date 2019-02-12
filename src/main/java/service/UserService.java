package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import dao.UserDao;
import domain.Board;
import domain.Game;
import domain.User;
import util.Pager;

@Service
public class UserService implements UserDetailsService {

	@Autowired
	private UserDao userDao;

	@Autowired
	private JavaMailSender javaMailSender;

	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		User user = userDao.selectOne(id);
		if (user == null) {
			throw new UsernameNotFoundException("존재하지 않는 유저");
		}
		return user;
	}

	public int nicknameDualCheck(String input) {
		return userDao.nicknameDualCheck(input);
	}

	public void update(User user) {
		userDao.update(user);
	}

	public void delete(String id) {
		userDao.delete(id);
	}
	
	public String sendCertifyEmail(String email) throws Exception {
		String from = "indiemoa.com@google.com";
		String subject = "[ INDIE MOA ] 인증메일";
		String emailCode = getRandomCode();
		String content = "[ INDIE MOA ] 회원가입 인증코드는 [" + emailCode + "]입니다.\n" + "인증코드를 입력하여 이메일 인증을 완료해 주세요";

		MimeMessage msg = javaMailSender.createMimeMessage();
		MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");
		helper.setFrom(from);
		helper.setTo(email);
		helper.setSubject(subject);
		helper.setText(content);
		javaMailSender.send(msg);

		return emailCode;
	}

	private String getRandomCode() {
		String randomCode = "";
		for (int i = 0; i < 4; i++) {
			randomCode += (int) (Math.random() * 10);
		}
		return randomCode;
	}

	public boolean checkValidEmail(String email) {
		String regex = "^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$";

		Pattern pattern = Pattern.compile(regex);

		Matcher matcher = pattern.matcher(email);

		return matcher.matches();
	}

	public boolean dupCheckEmail(String email) {
		User user = userDao.selectOneByEmail(email);
		if (user != null) {
			return true;
		}
		return false;
	}

	public void updateEmail(User user) {
		userDao.updateEmail(user);
	}

	public void insert(User user) {
		userDao.insert(user);
	}

	public User selectOne(String id) {
		return userDao.selectOne(id);
	}
	
	public User selectOneById(String id) {
		return userDao.selectOneById(id);
	}

	public int userTotal() {
		return userDao.userTotal();
	}

	public String getPage(int page) {
		int total = userDao.userTotal();
		return Pager.paging(page, total);
	}

	public List<User> getUserList(int page) {
		int start = (page -1) * Pager.BOARDS + 1;
		int end = start + Pager.BOARDS - 1;
		
		Map<String, Integer> map = new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		List<User> userList = userDao.userList(map);
		return userList;
	}

	public void manageUpdate(User user) {
		userDao.manageUpdate(user);
	}

	public void manageDelete(String id) {
		userDao.manageDelete(id);
	}

	public List<User> userSearchManage(String search) {
		return userDao.userSearchManage(search);
	}
	
	public List<User> userSearch(String search) {
		return userDao.userSearch(search);
	}

	public User getUserListSelectOne(String id) {
		return userDao.selectOne(id);
	}

	public List<User> userListRanking() {
		List<User> userList = userDao.userListRanking();
		return userList;
	}

	public void getExp10(String id) {
		userDao.getExp10(id);
	}

	public void getExp100(String id) {
		userDao.getExp100(id);
	}

}
