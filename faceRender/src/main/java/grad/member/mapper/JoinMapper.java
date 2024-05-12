package grad.member.mapper;

import java.util.Map;

public interface JoinMapper {
	public int idCheckSQL(Map<String,String> allparams);
	public void insertMemberSQL(Map<String,String> allparams);
}
