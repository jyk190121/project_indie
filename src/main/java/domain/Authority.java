package domain;

import org.springframework.security.core.GrantedAuthority;

public class Authority implements GrantedAuthority {

	private int id;
	private String users_id;
	private String role;
	
	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsers_id() {
		return users_id;
	}

	public void setUsers_id(String users_id) {
		this.users_id = users_id;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getAuthority() {
		return role;
	}

}
