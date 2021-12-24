package auditingSapMinimal.View;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Locale;

public class Intro {
	public Intro() {
		System.out.println("\033[H\033[2J");  
		System.out.flush();  
		System.out.println(ConsoleColors.CYAN);
		System.out.println("*****************************************************************************************************************************************");
		System.out.println("*");
		System.out.println("*" + ConsoleColors.CYAN_BRIGHT + " Auditing SAP HANA by L." + ConsoleColors.CYAN);
		System.out.println("*");
		System.out.println("* v0.0.1");
		System.out.println("*");
		System.out.println("* Based on: SAP HANA Security Checklists and Recommendations (Version: 1.0 – 2021-12-03), this is just a minimal/example console version. ");
		System.out.println("*");
		System.out.println("* For in-deep version, as well, for others systems/plattforms (Cybersecurity, Oracle, MySQL, AIX, among others), pls, contact me!");
		System.out.println("*");
		System.out.println("* Email: luis.alfie@gmail.com");
		System.out.println("*");
		System.out.println("*****************************************************************************************************************************************");
		System.out.println(ConsoleColors.WHITE_BRIGHT);
		SimpleDateFormat timeStamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss", Locale.getDefault());
		System.out.println("Starting at: " + timeStamp.format(Calendar.getInstance().getTime()));
		System.out.println(ConsoleColors.RESET);
	}
}
