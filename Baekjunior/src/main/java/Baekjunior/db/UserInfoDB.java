package Baekjunior.db;

import java.sql.*;
import javax.naming.NamingException;
import Baekjunior.db.DsCon;

public class UserInfoDB {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserInfoDB() throws NamingException, SQLException {
		con = DsCon.getConnection();
	}
	
	// 신규 유저 등록시, 이미 db상에 존재하는 아이디인지 체크하는 함수
	public int idCheck(String id) throws SQLException {
		String sql = "SELECT * FROM users WHERE user_id=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		// 이미 존재하는 아이디인 경우
		if(rs.next()) {
			return 1;
		}
		return 0;
	}
	
	// 신규 유저를 db에 저장하는 함수
	public void insertUser(UserInfo ui) throws SQLException {
		String sql = "INSERT INTO users (user_id, password, email) VALUES (?, ?, ?)";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, ui.getUser_id());
		pstmt.setString(2, ui.getPassword());
		pstmt.setString(3, ui.getEmail());
		
		pstmt.executeUpdate();
	}
	
	// 기존의 프로필 사진이 존재하는지 확인하는 함수
	public String imageExistCheck(String id) throws SQLException {
		String sql = "SELECT * FROM users WHERE user_id=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		rs.next();
		if(rs.getString("savedFileName") != null) {
			return rs.getString("savedFileName");
		}
		return "";
	}
	
	// 회원 정보에 프로필 사진을 추가하는 함수
	public void updateProfileImage(String id, String origin, String save) throws SQLException {
		String sql = "UPDATE users SET originalFileName=?, savedFileName=? WHERE user_id=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1,origin);
		pstmt.setString(2, save);
		pstmt.setString(3, id);
		
		pstmt.executeUpdate();
	}
	
	// 한줄소개 업데이트 하는 함수
	public void updateIntro(String id, String text) throws SQLException {
		String sql = "UPDATE users SET intro=? WHERE user_id=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, text);
		pstmt.setString(2, id);
		
		pstmt.executeUpdate();
	}
	
	// db 상에 해당 id와 password를 가진 유저가 존재하는지 확인하는 함수
	public int userExistCheck(String id, String pwd) throws SQLException {
		String sql = "SELECT * FROM users WHERE user_id=? AND password=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.setString(2, pwd);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			return 1;
		}
		return 0;
	}
	
	// 회원 탈퇴 함수. 해당 회원이 등록했던 problems, algorithm_sort, algorithm_memo 정보도 같이 삭제
	public void deleteUser(String id) throws SQLException {
		String sql = "DELETE FROM users	WHERE user_id=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		pstmt.close();
		
		sql = "DELETE FROM problems WHERE user_id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		pstmt.close();
		
		sql = "DELETE FROM algorithm_sort WHERE user_id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		pstmt.close();
		
		sql = "DELETE FROM algorithm_memo WHERE user_id=?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		pstmt.executeUpdate();
		pstmt.close();
	}
	
	public void close() throws SQLException	{
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(con != null) con.close();
	}
}
