package auditingSapMinimal.Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import auditingSapMinimal.Controller.MySQLHome;
import auditingSapMinimal.View.ConsoleColors;

public class Testing {

	public Testing(Connection sapConn, Connection mysqlConn, String idRecomendationType, String idRecomendation) throws Exception {

		MySQLHome mysqlHome= new MySQLHome();
		ResultSet recomendation=null;
		ResultSet testingToPerform=null;
		recomendation = mysqlHome.obtain_recomendation(mysqlConn, idRecomendationType, idRecomendation);
		testingToPerform = mysqlHome.obtain_testings(mysqlConn, idRecomendationType, idRecomendation);
		recomendation.next();
		System.out.println(ConsoleColors.WHITE + "Control: " + ConsoleColors.WHITE_BRIGHT + idRecomendationType + "." + idRecomendation);
		System.out.println(ConsoleColors.RESET);
		ResultSetMetaData rsmd=recomendation.getMetaData();
		for(int i=1; i<8;i++) {
			String colName=rsmd.getColumnLabel(i);
			String field = recomendation.getString(i);
			System.out.println(ConsoleColors.WHITE + colName + ": " + ConsoleColors.YELLOW + field);
			System.out.println();
		}
		System.out.println(ConsoleColors.WHITE + "Starting testings: ");
		System.out.println();

		int numTest=1;
		while(testingToPerform.next()) {
			System.out.println(ConsoleColors.WHITE + numTest + "): " + ConsoleColors.YELLOW + "'" + testingToPerform.getString(2) + "'");
			System.out.println();
			//TODO 
			//Incorporated in the full version, here you can include the testing of queries, OS commands, etc.
			//For instance:
			switch(testingToPerform.getString(3)) {
				case "Query":
					//call sapHome and running the query
				case "Command":
					//call system call and running the command
				default:	
					//others procedures
			}
		}
		recomendation.close();
		testingToPerform.close();
	}
}
