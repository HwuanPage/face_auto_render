package grad.aop;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Aspect
@Component
public class LoggingAspect {

	private static final Logger log = LogManager.getLogger(LoggingAspect.class);

	@Before("execution(* grad.member.controller..*.*(..))")
	public void logBefore(JoinPoint joinPoint) {
		log.info("##{} Method Start ##", joinPoint.getSignature().getName());

	}

	@After("execution(* grad.member.controller..*.*(..))")
	public void logAfter(JoinPoint joinPoint) {
		log.info("##{} Method End ##", joinPoint.getSignature().getName());
	}

}