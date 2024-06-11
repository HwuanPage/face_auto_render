package grad.member.controller;

import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.core.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import grad.member.service.JoinServiceIF;

@Controller
public class JoinController {

	private static final Logger log = (Logger) LogManager.getLogger(JoinController.class);
	private JoinServiceIF service;
	
	public JoinController(JoinServiceIF service) {
		this.service = service;
	}
	@GetMapping("/member/joinForm")
	public ModelAndView getMemberJoinForm() {

		ModelAndView mav = new ModelAndView();

		mav.setViewName("member/join-form");

		return mav;

	}
	@ResponseBody
	@PostMapping("/member/join")
	public Map<String,Object> join(@RequestParam Map<String, String> allParams) {

		

		log.info("파라미터 넘어온 것을 찍어 보자.");
		log.info(allParams.toString());
		log.info("파라미터 넘어온 것을 찍어 보자.");

		return service.addMemberService(allParams);

	}
}
