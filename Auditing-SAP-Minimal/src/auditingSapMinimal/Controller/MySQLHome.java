package auditingSapMinimal.Controller;

import java.sql.*;

public class MySQLHome {

	private Connection connection = null;

	public MySQLHome() {}

	public Connection createConn(String server, int port, String db, String username, String password) throws Exception {
		connection = DriverManager.getConnection("jdbc:mysql://"+server+":"+port+"/"+db, username,password);                  
		return connection;
	}

	public ResultSet obtain_recomendation(Connection mysqlConn, String recommendationType, String recommendation) throws Exception {
		Statement stmt = mysqlConn.createStatement();
		ResultSet resultSet = stmt.executeQuery("SELECT "
				+ "`rt`.`Title` AS `Recommendation Type`"
				+ ",`r`.`Title` AS `Title`"
				+ ",`r`.`Default` AS `Default`"
				+ ",`r`.`Recommendation` AS `Recommendation`"
				+ ",`r`.`How_to_Verify` AS `How to Verify`"
				+ ",`r`.`Related_Alert` AS `Related Alert`"
				+ ",`r`.`More_Information` AS `More Information`"
				+ "FROM\n"
				+ "(`Recommendations` `r` "
				+ "JOIN `Recommendations_Types` `rt`) "
				+ "WHERE\n"
				+ "(`r`.`idRecommendations_Types` = `rt`.`idRecommendations_Types`)");
		return resultSet;	
	}

	public ResultSet obtain_testings(Connection mysqlConn, String recomendationType, String recomendation) throws Exception {
		Statement stmt;
		ResultSet resultSet;
		stmt = mysqlConn.createStatement();
		resultSet = stmt.executeQuery("SELECT idTesting as `Id`"
				+ ", Query"
				+ ", Testing_Type as `Testing Type` "
				+ "FROM Testings, Testing_Types "
				+ "WHERE IdRecommendation_Type = '" + recomendationType 
				+ "' and IdRecommendation='"+ recomendation + "' "
				+ "and idTesting_Type=idTesting_Types;");
		return resultSet;
	}

	public void disconnect(Connection mysqlConn) throws Exception {
		mysqlConn.close();
	}

}
