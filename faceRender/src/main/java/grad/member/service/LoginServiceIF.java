package grad.member.service;

import java.util.List;
import java.util.Map;

import grad.member.model.Member;

public interface LoginServiceIF {
	
	public Member loginMemberService(Map<String,String> allParams);

}
