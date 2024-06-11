package grad.member.service;

import java.util.Map;

import grad.member.model.Member;

public interface JoinServiceIF {
	public Map<String,Object> addMemberService(Map<String, String> allParams);
}
