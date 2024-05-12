package grad.member.service;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Service;

import grad.member.mapper.LoginMapper;
import grad.member.model.Member;
/**
 * 로그인 서비스 클래스
 * 
 * @author HwuanPage
 * @since 2024.05.06
 */
@Service
public class LoginServiceImpl implements LoginServiceIF{

	private static final Logger log = (Logger) LogManager.getLogger(LoginServiceImpl.class);

	private LoginMapper loginMapper;
	
	
	/**
	 * MemberServiceImpl 생성자
	 * 
	 * @author HwuanPage
	 * @param LoginMapper
	 */
	public LoginServiceImpl(LoginMapper loginMapper) {
		this.loginMapper=loginMapper;
	}
	/**
	 * 로그인 메서드
	 * 
	 * @author HwuanPage
	 * @param LoginMapper
	 */
	@Override
	public Member loginMemberService(Map<String,String> allParams) {
		Member loggedMem = loginMapper.loginMemberSQL(allParams);
		log.info("db 설치 결과");
		log.info(loggedMem.toString());
		return loggedMem;
	}
	

}
