package Baekjunior.db;

import java.sql.*;
import javax.naming.NamingException;
import Baekjunior.db.DsCon;

public class AlgorithmSortDB {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public AlgorithmSortDB() throws NamingException, SQLException {
		con = DsCon.getConnetion();
	}
	public void insertAlgorithmSort(String userId, int problemIdx, String[] algorithms) throws SQLException {
        String sql = "INSERT INTO algorithm_sort (user_id, problem_idx, sort) VALUES (?, ?, ?)";
        
        if(algorithms.length == 0) {
        	return;
        }
        pstmt = con.prepareStatement(sql);
        for (String algo : algorithms) {
            pstmt.setString(1, userId);
            pstmt.setInt(2, problemIdx); // Use the correct key here
            pstmt.setString(3, algo);
            pstmt.addBatch();
        }
        pstmt.executeBatch();
    }
	public void close() throws SQLException {
		if(rs != null) rs.close();
		if(pstmt != null) pstmt.close();
		if(con != null) con.close();
	}
}
