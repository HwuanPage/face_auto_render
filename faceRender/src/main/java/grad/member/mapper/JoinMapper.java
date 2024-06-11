package grad.member.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
@Mapper
public interface JoinMapper {
	public int selectDuplicateMemberSQL(Map<String, String> allParams);
	public void insertMemberSQL(Map<String,String> allparams);
}
