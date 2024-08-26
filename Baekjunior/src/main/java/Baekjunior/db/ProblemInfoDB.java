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
	/*
	 * public int problemExistCheck(String title) throws SQLException { String sql =
	 * "SELECT * FROM problems WHERE title=?";
	 * 
	 * pstmt = con.prepareStatement(sql); pstmt.setString(1, title); rs =
	 * pstmt.executeQuery(); if(rs.next()) { return 1; } return 0; }
	 */
	
	// 문제 정보 db에 추가하는 함수
	public void insertProblem(ProblemInfo pi) throws SQLException {
		String sql = "INSERT INTO problems (user_id, problem_id, problem_title, problem_url, problem_sort, tier_name, tier_num, level, code, language, is_checked)" +
					" VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		
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
		pstmt.setString(10, pi.getLanguage());
		pstmt.setInt(11, pi.getIs_checked());
		
		pstmt.executeUpdate();
		
		// 문제 풀이에 대한 고유 번호 저장
		rs = pstmt.getGeneratedKeys();
		if(rs.next()) {
			pi.setProblem_idx(rs.getInt(1));
		}
	}
	
	// 노트 제목을 사용자가 직접 지정할 경우
	public void insertMemoTitle(int problem_idx, String memo_title) throws SQLException {
		String sql = "UPDATE problems SET memo_title=? WHERE problem_idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, memo_title);
		pstmt.setInt(2, problem_idx);
		
		pstmt.executeUpdate();
	}
	
	// 한 문제에 대한 필기를 여러개 할 경우를 대비해, memo_title을 따로 지정해주는 함수
	public void updateMemoTitle(int problem_idx, String problem_title) throws SQLException {
		String sql = "UPDATE problems SET memo_title=? WHERE problem_idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, problem_title + " (" + problem_idx + ")" );
		pstmt.setInt(2, problem_idx);
		
		pstmt.executeUpdate();
	}
	
	// 문제 필기 정보를 수정하는 함수
	public void updateProblem (ProblemInfo pi) throws SQLException {
		String sql = "UPDATE problems SET code=?, main_memo=?, sub_memo=? WHERE problem_idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, pi.getCode());
		pstmt.setString(2, pi.getMain_memo());
		pstmt.setString(3, pi.getSub_memo());
		pstmt.setInt(4, pi.getProblem_idx());
		
		pstmt.executeUpdate();
	}
	
	// 북마크 여부를 업데이트 하는 함수
	public void updateBookmark(int problem_idx, int is_checked) throws SQLException {
		String sql = "UPDATE problems SET is_checked=? WHERE problem_idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, is_checked);
		pstmt.setInt(2, problem_idx);
		
		pstmt.executeUpdate();
	}
	
	// 고정 여부를 업데이트 하는 함수
	public void updatePin(int problem_idx, int is_fixed) throws SQLException {
		String sql = "UPDATE problems SET is_fixed=? WHERE problem_idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, is_fixed);
		pstmt.setInt(2, problem_idx);
		
		pstmt.executeUpdate();
	}
	
	// 문제 필기를 삭제하는 함수
	public void deleteProblem(int problem_idx) throws SQLException {
		String sql = "DELETE FROM problems WHERE problem_idx=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, problem_idx);
		
		pstmt.executeUpdate();
		pstmt.close();
		
		// 해당 문제가 분류된 알고리즘도 삭제
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
