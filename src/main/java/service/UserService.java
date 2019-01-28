package service;

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
import domain.User;

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
	

}
