package service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.PostConstruct;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import dao.UserDao;
import domain.User;

@Service
public class UserService implements UserDetailsService {

	@Autowired
	private UserDao userDao;

	@Autowired
	private JavaMailSender javaMailSender;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	int a = 300;
	int[] levUp = new int[a];
	
	@PostConstruct
	public void init() {
		for(int i=0; i<=a-1; i++) {
			levUp[i] = i*20;
		}
	}

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
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		userDao.update(user);
	}

	public void delete(String id) {
		userDao.delete(id);
	}
	
	public String sendCertifyEmail(String email) throws Exception {
		String from = "indiemoa.com@google.com";
		String subject = "[ INDIE MOA ] 인증메일";
		String emailCode = getRandomCode(5);
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

	public String getRandomCode(int n) {
		String randomCode = "";
		for (int i = 0; i < n; i++) {
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
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		userDao.insert(user);
	}

	public User selectOne(String id) {
		return userDao.selectOne(id);
	}
	
	public User selectOneById(String id) {
		return userDao.selectOneById(id);
	}

	public List<User> userList(Map<String, String> map) {
		return userDao.userList(map);
	}
	
	public void getExp(String id, int exp) {
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		map.put("exp", exp);
		userDao.getExp(map);
		User user = selectOne(id);
		levUp(id,user.getExp(),user.getLev());
	}


	public void manageUpdate(User user) {
		userDao.manageUpdate(user);
	}

	public void levUp(String id, int exp, int lev) {
		/*String str = "{1, 2 ";
		int a = 1;
		int b = 2;
		int c = 0;
		for(int i=0; i<=100; i++) {
			str+=",";
			c = i*20;
			str+= String.valueOf(c);
		}
		str+="}";
		System.out.println(str);*/
		Map<String, Object> map = new HashMap<>();
		map.put("id", id);
		while(true) {
			map.put("exp", exp);
			map.put("levUpExp", levUp[lev]);
			if(exp >= levUp[lev]) {
				userDao.levUp(map);
				exp -= levUp[lev];
				lev += 1;
			}else if(exp < levUp[lev]) {
				break;
			}
		}
		
	}

	public User selectOnebyWriter_id(int writer_id) {
		return userDao.selectOnebyWriter_id(writer_id);
	}

	public User selectOneByEmail(String email) {
		return userDao.selectOneByEmail(email);
	}
}
