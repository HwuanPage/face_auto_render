package grad.member.model;

import lombok.Data;

@Data
public class Member {
	
	private int memberSeq;
	private String memberId;
	private String memberPwd;
	private String memberName;
	private String memberIsSuper;
	private String memberIsVaild;
	private String regDtime;

}
