package Baekjunior.db;

import java.sql.*;
import javax.naming.NamingException;
import Baekjunior.db.DsCon;

public class ProblemInfoDB {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public ProblemInfoDB() throws NamingException, SQLException {
		con = DsCon.getConnetion();
	}
	
	// 
	public int problemExistCheck(String title) throws SQLException {
		String sql = "SELECT * FROM problems WHERE title=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, title);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			return 1;
		}
		return 0;
	}
	
	public void insertProblem(ProblemInfo pi) throws SQLException {
		String sql = "INSERT INTO problems (user_id, problem_id, problem_title, problem_url, tier_name, tier_num, level, code, is_checked)" +
					" VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		pstmt.setString(1, pi.getUser_id());
		pstmt.setInt(2, pi.getProblem_id());
		pstmt.setString(3, pi.getProblem_title());
		pstmt.setString(4, pi.getProblem_url());
		pstmt.setString(5, pi.getTier_name());
		pstmt.setInt(6, pi.getTier_num());
		pstmt.setInt(7, pi.getLevel());
		pstmt.setString(8, pi.getCode());
		pstmt.setInt(9, pi.getIs_checked());
		
		pstmt.executeUpdate();
		
		// 문제 풀이에 대한 고유 번호 저장
		rs = pstmt.getGeneratedKeys();
		if(rs.next()) {
			pi.setProblem_idx(rs.getInt(1));
		}
		
	}
	
	public void close() throws SQLException {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(con != null) con.close();
	}
}
