package domain;

import java.util.Collection;
import java.util.List;

import javax.validation.constraints.Pattern;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.multipart.MultipartFile;

public class User implements UserDetails{

	@Pattern(regexp = "[a-zA-Z0-9]{4,20}", message = "아이디는 영문과 숫자 4 ~ 20 글자로 구성됨")
	private String id;
	@Pattern(regexp = "[0-9A-Za-z!@#*_-]{4,20}", message = "비밀번호는 숫자와 영문, 특수문자(!@#*_-) 4 ~ 20 글자로 구성됨")
	private String password;
	@Pattern(regexp = "[ㄱ-ㅎ가-힣ㅏ-ㅣ0-9A-Za-z!@#*_-]{4,20}", message = "닉네임은 숫자와 영문, 한글, 특수문자(!@#*_-) 4 ~ 20 글자로 구성됨")
	private String nickname;
	@Pattern(regexp = "[a-zA-Z0-9]{1,30}@[a-zA-Z0-9]{1,30}\\.[a-zA-Z0-9]{1,10}", message = "이메일 형식을 올바르게 입력하세요")
	private String email;
	private String image;
	private String myinfo;
	private int lev;
	private int exp;

	private List<Authority> authorities;
	
	private MultipartFile image_file;
	
	public MultipartFile getImage_file() {
		return image_file;
	}
	public void setImage_file(MultipartFile image_file) {
		this.image_file = image_file;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getMyinfo() {
		return myinfo;
	}
	public void setMyinfo(String myinfo) {
		this.myinfo = myinfo;
	}
	public int getLev() {
		return lev;
	}
	public void setLev(int lev) {
		this.lev = lev;
	}
	public int getExp() {
		return exp;
	}
	public void setExp(int exp) {
		this.exp = exp;
	}
	
	public Collection<? extends GrantedAuthority> getAuthorities() {
		// TODO Auto-generated method stub
		return authorities;
	}
	public String getUsername() {
		// TODO Auto-generated method stub
		return id;
	}
	public void setAuthorities(List<Authority> authorities) {
		this.authorities = authorities;
	}
	public boolean isAccountNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	public boolean isAccountNonLocked() {
		// TODO Auto-generated method stub
		return true;
	}
	public boolean isCredentialsNonExpired() {
		// TODO Auto-generated method stub
		return true;
	}
	public boolean isEnabled() {
		// TODO Auto-generated method stub
		return true;
	}

}
