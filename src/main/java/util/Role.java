package util;

import org.springframework.security.core.GrantedAuthority;

import domain.User;

public class Role {
	public static boolean hasRole(User user, String role) {
		boolean hasRole = false;
		for(GrantedAuthority authority : 
							user.getAuthorities()){
			if(authority.getAuthority().equals(role)) {
				hasRole = true;
				break;
			}
		}
		return hasRole;
	}
}
