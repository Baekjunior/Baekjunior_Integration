package Baekjunior.db;

import java.sql.*;
import javax.naming.NamingException;
import Baekjunior.db.DsCon;

public class AlgorithmMemoDB {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public AlgorithmMemoDB() throws NamingException, SQLException {
		con = DsCon.getConnection();
	}
	
	public int algorithmExistCheck(String algorithm_name) throws SQLException {
		String sql = "SELECT * FROM algorithm_memo WHERE algorithm_name=?";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, algorithm_name);
		rs = pstmt.executeQuery();
		if(rs.next()) {
			return 1;
		}
		return 0;
	}
	
	public void insertAlgorithmMemo(String user_id, String algorithm_name) throws SQLException {
		String sql = "INSERT INTO algorithm_memo (user_id, algorithm_name) VALUES (?, ?)";
		
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, user_id);
		pstmt.setString(2, algorithm_name);
		
		pstmt.executeUpdate();
	}
	
	public void close() throws SQLException {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(con != null) con.close();
	}
}
