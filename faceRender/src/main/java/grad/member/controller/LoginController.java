package grad.member.controller;

import java.util.List;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import grad.member.model.Member;
import grad.member.service.LoginServiceIF;

@Controller
public class LoginController {

	private static final Logger log = (Logger) LogManager.getLogger(LoginController.class);
	private LoginServiceIF service;
	
	
	public LoginController(LoginServiceIF service) {
		this.service=service;
	}
	
	@GetMapping("/member/loginForm")
	public ModelAndView getMemberLoginForm() {
		ModelAndView mav = new ModelAndView();
		
		mav.setViewName("member/login-form");
		return mav;
	}
	
	@ResponseBody
	@GetMapping("/member/login")
	public Member login(@RequestParam Map<String,String> allParams){

		log.info("파라미터 넘어온 것을 찍어 보자.");
		log.info(allParams.toString());
		log.info("파라미터 넘어온 것을 찍어 보자.");

		Member result = service.loginMemberService(allParams);
		return result;
	}
}
