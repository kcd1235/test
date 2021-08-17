package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import VO.MemberVO;

public class MemberDAO {
	private static MemberDAO dao = new MemberDAO();
	DBConnectionMgr pool = DBConnectionMgr.getInstance();
	private MemberDAO(){}

	public static MemberDAO getInstance() {
		return dao;
	}
	
	public void memberJoin(MemberVO member) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			conn = pool.getConnection();
			pstmt = conn.prepareStatement("insert into membertbl values(?,?,?,?,?,?,?,?)");
			pstmt.setString(1, member.getUserid());
			pstmt.setString(2, member.getPwd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getPh());
			pstmt.setString(5, member.getEmail());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(conn, pstmt);
		}
	}
}
