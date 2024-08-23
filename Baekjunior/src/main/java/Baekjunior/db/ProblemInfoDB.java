package Baekjunior.db;

import java.sql.*;
import javax.naming.NamingException;
import Baekjunior.db.DsCon;

public class ProblemInfoDB {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public ProblemInfoDB() throws NamingException, SQLException {
		con = DsCon.getConnection();
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
		String sql = "INSERT INTO problems (user_id, problem_id, problem_title, problem_url, problem_sort, tier_name, tier_num, level, code, is_checked)" +
					" VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
		pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
		pstmt.setString(1, pi.getUser_id());
		pstmt.setInt(2, pi.getProblem_id());
		pstmt.setString(3, pi.getProblem_title());
		pstmt.setString(4, pi.getProblem_url());
		pstmt.setString(5, pi.getProblem_sort());
		pstmt.setString(6, pi.getTier_name());
		pstmt.setInt(7, pi.getTier_num());
		pstmt.setInt(8, pi.getLevel());
		pstmt.setString(9, pi.getCode());
		pstmt.setInt(10, pi.getIs_checked());
		
		pstmt.executeUpdate();
		
		// 문제 풀이에 대한 고유 번호 저장
		rs = pstmt.getGeneratedKeys();
		if(rs.next()) {
			pi.setProblem_idx(rs.getInt(1));
		}
	}
	
	public void insertMemoTitle(int problem_idx, String problem_title) throws SQLException {
		String sql = "UPDATE problems SET memo_title=? WHERE problem_idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, problem_title + " (" + problem_idx + ")" );
		pstmt.setInt(2, problem_idx);
		
		pstmt.executeUpdate();
	}
	
	public void updateProblem (ProblemInfo pi) throws SQLException {
		String sql = "UPDATE problems SET code=?, main_memo=?, sub_memo=? WHERE problem_idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, pi.getCode());
		pstmt.setString(2, pi.getMain_memo());
		pstmt.setString(3, pi.getSub_memo());
		pstmt.setInt(4, pi.getProblem_idx());
		
		pstmt.executeUpdate();
	}
	
	public void updateBookmark(int problem_idx, int is_checked) throws SQLException {
		String sql = "UPDATE problems SET is_checked=? WHERE problem_idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, is_checked);
		pstmt.setInt(2, problem_idx);
		
		pstmt.executeUpdate();
	}
	
	public void deleteProblem(int problem_idx) throws SQLException {
		String sql = "DELETE FROM problems WHERE problem_idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, problem_idx);
		
		pstmt.executeUpdate();
		pstmt.close();
		
		sql = "DELETE FROM algorithm_sort WHERE problem_idx=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, problem_idx);
		
		pstmt.executeUpdate();
		pstmt.close();
	}
	
	public void close() throws SQLException {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(con != null) con.close();
	}
}
