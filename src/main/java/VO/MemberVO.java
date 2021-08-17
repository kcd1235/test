package VO;

public class MemberVO {
 
	private String userid; 
	private String pwd;
	private String name ;
	private String ph1;
	private String ph2;
	private String ph3;
	private String email;
	
	public MemberVO(String userid,String pwd,String name,String ph1,String ph2,String ph3,String email) {
		this.userid = userid;
		this.pwd = pwd;
		this.name = name;
		this.ph1=ph1;
		this.ph2=ph2;
		this.ph3=ph3;
		this.email=email;
	}
	
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getPh() {
		return ph1+"-"+ph2+"-"+ph3;
	}
	
	public String getPh1() {
		return ph1;
	}
	public void setPh1(String ph1) {
		this.ph1 = ph1;
	}
	public String getPh2() {
		return ph2;
	}
	public void setPh2(String ph2) {
		this.ph2 = ph2;
	}
	public String getPh3() {
		return ph3;
	}
	public void setPh3(String ph3) {
		this.ph3 = ph3;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}
