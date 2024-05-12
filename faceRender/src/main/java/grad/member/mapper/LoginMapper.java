package grad.member.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import grad.member.model.Member;

@Mapper
public interface LoginMapper {

	public Member loginMemberSQL(Map<String,String> allParams);
}
