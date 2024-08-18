package Baekjunior.db;

import javax.naming.*;
import java.sql.*;
import javax.sql.DataSource;

public class DsCon {
	public static Connection getConnetion() throws NamingException, SQLException {
		
		Context initContext = new InitialContext();
		DataSource ds = (DataSource)initContext.lookup("java:/comp/env/jdbc/mydbTest");
		return ds.getConnection();
	}
}
