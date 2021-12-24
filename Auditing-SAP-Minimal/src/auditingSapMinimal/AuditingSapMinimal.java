package auditingSapMinimal;

import java.sql.Connection;

import auditingSapMinimal.Controller.MySQLHome;
import auditingSapMinimal.Controller.SAPHome;
import auditingSapMinimal.Model.Testing;
import auditingSapMinimal.View.ConsoleColors;
import auditingSapMinimal.View.Intro;

public class AuditingSapMinimal {

	private static String SAP_SERVER = "192.168.1.6";
	private static int SAP_PORT = 30015;
	private static String SAP_USERNAME = "sapUsername";
	private static String SAP_PASSWORD = "sapPassword";

	private static String MYSQL_SERVER = "192.168.1.6";
	private static int MYSQL_PORT = 3306;
	private static String MYSQL_DB = "Auditing-SAP-Minimal";
	private static String MYSQL_USERNAME = "Auditing-SAP-Minimal";
	private static String MYSQL_PASSWORD = "Auditing-SAP-Minimal-Pass";

	public static void main(String[] args) {
		
		new Intro();
		
		// SAP Connection
		Connection sapConn=null;
		SAPHome sapHome=new SAPHome();
		try {
			sapConn = sapHome.createConn(SAP_SERVER, SAP_PORT, SAP_USERNAME, SAP_PASSWORD);
		} catch (Exception e) {
			System.err.println(ConsoleColors.RED + "SAP Connection Failed: " + e);
			System.out.println(ConsoleColors.RESET);
			return;
		}
		System.out.println(ConsoleColors.GREEN + "Connection to SAP successful...");
		System.out.println(ConsoleColors.RESET);

		// MySQL Connection
		Connection mysqlConn=null;
		MySQLHome mysqlHome=new MySQLHome();
		try {
			mysqlConn = mysqlHome.createConn(MYSQL_SERVER, MYSQL_PORT, MYSQL_DB, MYSQL_USERNAME, MYSQL_PASSWORD);
		} catch (Exception e) {
			System.err.println(ConsoleColors.RED + "MySQL Connection Failed: " + e);
			System.out.println(ConsoleColors.RESET);
			return;
		}
		System.out.println(ConsoleColors.GREEN + "Connection to MySQL successful...");
		System.out.println(ConsoleColors.RESET);

		//Testings to perform
		try {
			new Testing(sapConn, mysqlConn, "2.1", "1");
			//here you can add following testings
			//new Testing(sapConn, mysqlConn, "2.2", "1");
		} catch (Exception e) {
			System.err.println(ConsoleColors.RED + e);
			System.out.println(ConsoleColors.RESET);
		}
		try {
			sapHome.disconnect(sapConn);
			mysqlHome.disconnect(mysqlConn);
		} catch (Exception e) {
			System.err.println(ConsoleColors.RED + e);
			System.out.println(ConsoleColors.RESET);
		}

		System.out.println(ConsoleColors.WHITE + "Script finished: " + ConsoleColors.GREEN + "OK.");
		System.out.println();
	}
}
