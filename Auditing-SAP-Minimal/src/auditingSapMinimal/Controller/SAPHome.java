package auditingSapMinimal.Controller;

import java.sql.*;

public class SAPHome {

	private Connection connection = null;

	public SAPHome() {}

	public Connection createConn(String server, int port, String username, String password) throws Exception {
		connection = DriverManager.getConnection("jd bc:sap://"+server+":"+port+"/?autocommit=false", username,password);                  
		return connection;
	}

	public ResultSet perform_query(Connection sapConn, String query) throws Exception {
		Statement stmt = sapConn.createStatement();
		ResultSet resultSet = stmt.executeQuery(query);
		stmt.close();
		return resultSet;
	}

	public void disconnect(Connection sapConn) throws Exception {
		sapConn.close();
	}
}
