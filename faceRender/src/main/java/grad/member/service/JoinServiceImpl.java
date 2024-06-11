package grad.member.service;

import java.util.HashMap;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.stereotype.Service;

import grad.member.mapper.JoinMapper;

@Service
public class JoinServiceImpl implements JoinServiceIF{
	private static final Logger log = (Logger) LogManager.getLogger(JoinServiceImpl.class);
	private JoinMapper joinMapper;
	
	public JoinServiceImpl(JoinMapper joinMapper) {
		this.joinMapper = joinMapper;
	}
	@Override
	public Map<String,Object> addMemberService(Map<String, String> allParams) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("REPL_CD", "000000");
		result.put("REPL_MSG", "SUCCESS");

		try {

			// 휴대폰 번호 검증
			int memberCnt = joinMapper.selectDuplicateMemberSQL(allParams);

			log.info("*******************");
			log.info("동일 아이디 = " + memberCnt);
			log.info("*******************");

			if (memberCnt > 0) {
				result.put("REPL_CD", "000001");
				result.put("REPL_MSG", "아이디를 사용할수 없습니다.");
			} else {
				joinMapper.insertMemberSQL(allParams);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		return result;
	}
	

}
