import java.sql.* ;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Scanner;

public class GoBabbyApp {
	
	private static int pracId;

	public static void main(String[] args) throws SQLException {
		//Do all the DB connection logic
		int sqlCode=0;      // Variable to hold SQLCODE
        String sqlState="00000";  // Variable to hold SQLSTATE

        // Register the driver.  You must register the driver before you can use it.
        try { DriverManager.registerDriver ( new com.ibm.db2.jcc.DB2Driver() ) ; }
        catch (Exception cnfe){ System.out.println("Class not found"); }

        // This is the url you must use for DB2.
        //Note: This url may not valid now ! Check for the correct year and semester and server name.
        String url = "jdbc:db2://winter2022-comp421.cs.mcgill.ca:50000/cs421";

        //REMEMBER to remove your user id and password before submitting your code!!
        String your_userid = "";
        String your_password = "";
 
        if(your_userid == null && (your_userid = System.getenv("SOCSUSER")) == null)
        {
          System.err.println("Error!! do not have a password to connect to the database!");
          System.exit(1);
        }
        if(your_password == null && (your_password = System.getenv("SOCSPASSWD")) == null)
        {
          System.err.println("Error!! do not have a password to connect to the database!");
          System.exit(1);
        }

        Connection con = DriverManager.getConnection (url,your_userid,your_password) ;
        Statement statement = con.createStatement ( ) ;
		
		//HANDLE THE COMMAND PROMPT FUNCTIONALITY
		
		Scanner command = new Scanner(System.in);

		boolean EnotPressed = true;
    	//GET THE WIFE ID
    	while (EnotPressed) {
    		System.out.println("Please enter your practitioner id [E] to exit: ");
    		String nl = command.nextLine();
    		if (nl.equals("E")) EnotPressed = false;
    		else pracId = findPractitionerId(nl, statement, sqlCode, sqlState);
    		if (pracId != -1) break;
    		System.out.println("ID is invalid or cannot be found\n");
    	}
    	
    	//GET THE APPOINTMENT DATE
    	findApptDateSelection(command, pracId, statement, sqlCode, sqlState);
    	
    	
		       
		command.close();
		statement.close ( ) ;
        con.close ( ) ;
	}

	private static ArrayList<Appointment> selectOption(ArrayList<Appointment> appts, Scanner command, int pracId2, Statement statement, int sqlCode, String sqlState) {
		
		while (true) {
    		System.out.println("Enter the appointment number that you would like to work on.\r\n"
    				+ "[E] to exit [D] to go back to another date :");
    		String nl = command.nextLine();
    		if (nl.equals("E")) break;
    		else if (nl.equals("D")) {return new ArrayList<Appointment>();}
    		int id = Integer.parseInt(nl);
    		if (id >= 1 && id <= appts.size()) {
    			loadMenu(appts.get(id-1), command, pracId, statement, sqlCode, sqlState);
    			printAppointments(appts);
    		}
    		else System.out.println("Please enter a valid id found above\n");
    	}
		return appts;
		
	}

	private static void loadMenu(Appointment appt, Scanner command, int pracId2, Statement statement,
			int sqlCode, String sqlState) {
		while(true) {
			System.out.println("For " + appt.getName() + " " + appt.getHcardid());
			System.out.println("1. Review notes\r\n"
			+ "2. Review tests\r\n"
			+ "3. Add a note\r\n"
			+ "4. Prescribe a test\r\n"
			+ "5. Go back to the appointments.\r\n"
			+ "");
			System.out.println("Enter you choice: ");
			String nl = command.nextLine();
			int option = Integer.parseInt(nl);
			
			if(option == 1) {reviewNoteMenu(appt.getPreg_id(), statement, sqlCode, sqlState);}
			else if (option == 2) {reviewTestMenu(appt.getPreg_id(), statement, sqlCode, sqlState);}
			else if (option == 3) {writeNote(appt,command, statement, sqlCode, sqlState);}
			else if (option == 4) {prescribeTest(appt,command, statement, sqlCode, sqlState);}
			else if (option == 5) {break;}
		}
	}

	private static void prescribeTest(Appointment appt, Scanner command, Statement statement, int sqlCode,
			String sqlState) {
		while(true) {
			System.out.println("Please enter the type of test: ");
			String nl = command.nextLine();
	        int last_id = 0;
			try
	        {
	        	String querySQL = "SELECT COUNT(*) FROM TEST";
	            java.sql.ResultSet rs = statement.executeQuery ( querySQL ) ;

	            while ( rs.next ( ) )
	            { 
	              last_id = rs.getInt ( 1 ) ;
	            }	
	            int id = last_id +1;
	            Calendar cal = Calendar.getInstance();
	            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	            String fdate = format.format(cal.getTime());
	            
	            
	            String insertSQL = "INSERT INTO TEST VALUES ("+id+","+appt.getAppt_id()+",'"+fdate+"', NULL , '"+nl+"', NULL, NULL, false, NULL, NULL, NULL) " ;
	            statement.executeUpdate ( insertSQL ) ;
	            System.out.println("\n");
	            break;
	            
	        }
	        catch (SQLException e)
	        {
	          sqlCode = e.getErrorCode(); // Get SQLCODE
	          sqlState = e.getSQLState(); // Get SQLSTATE  
	          System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
	          System.out.println(e);
	        }
	       	
		}
		
	}

	private static void writeNote(Appointment appt, Scanner command, Statement statement, int sqlCode,
			String sqlState) {
		while(true) {
			System.out.println("Please type your observation: ");
			String nl = command.nextLine();
	        int last_id = 0;
			try
	        {
	        	String querySQL = "SELECT COUNT(*) FROM NOTES";
	            java.sql.ResultSet rs = statement.executeQuery ( querySQL ) ;

	            while ( rs.next ( ) )
	            { 
	              last_id = rs.getInt ( 1 ) ;
	            }	
	            int id = last_id +1;
	            Calendar cal = Calendar.getInstance();
	            SimpleDateFormat format1 = new SimpleDateFormat("yyyy-MM-dd");
	            String fdate = format1.format(cal.getTime());
	            
	            Date time = new Date(System.currentTimeMillis());
	            String ftime = new SimpleDateFormat("HH:mm:ss").format(time);
	            
	            String insertSQL = "INSERT INTO NOTES VALUES ( "+id+", "+appt.getAppt_id()+",'"+ftime+"','"+fdate+"','"+nl+"') " ;
	            statement.executeUpdate ( insertSQL ) ;
	            System.out.println("\n");
	            break;
	            
	        }
	        catch (SQLException e)
	        {
	          sqlCode = e.getErrorCode(); // Get SQLCODE
	          sqlState = e.getSQLState(); // Get SQLSTATE  
	          System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
	          System.out.println(e);
	        }
	        
			
		}
		
	}

	private static void reviewTestMenu(int preg_id,Statement statement, int sqlCode, String sqlState) {
		boolean found = false;
        try
        {
          String querySQL = "SELECT test_date, testType, testResult "
          		+ "FROM TEST t, "
          		+ "(SELECT appt_id "
          		+ "FROM Appointments a "
          		+ "WHERE a.pregnancy_id = "+preg_id+") ap "
          		+ "WHERE t.appt_id = ap.appt_id AND isForBaby = false "
          		+ "ORDER BY test_date;";
          java.sql.ResultSet rs = statement.executeQuery ( querySQL ) ;

          while ( rs.next ( ) )
          {
        	found = true;
        	String t_result = rs.getString("testResult");
        	if (t_result == null) {t_result = "result not yet concluded";}
        	System.out.println(rs.getString("test_date")+ "  [" + rs.getString("testType") + "]  " + t_result.substring(0, Math.min(t_result.length(), 50)));
        	          
          }
        }
        catch (SQLException e)
        {
          sqlCode = e.getErrorCode(); // Get SQLCODE
          sqlState = e.getSQLState(); // Get SQLSTATE  
          System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
          System.out.println(e);
        }
        System.out.println("\n");
        if (!found) System.out.print("No tests are found for this pregnancy");
        System.out.println("\n");
	}


	private static void reviewNoteMenu(int preg_id,Statement statement, int sqlCode, String sqlState) {
		boolean found = false;
        try
        {
          String querySQL = "SELECT ndate, time, description "
          		+ "FROM NOTES n, "
          		+ "(SELECT appt_id "
          		+ "FROM Appointments a "
          		+ "WHERE a.pregnancy_id = "+preg_id+") ap "
          		+ "WHERE n.appt_id = ap.appt_id "
          		+ "ORDER BY ndate, time;";
          java.sql.ResultSet rs = statement.executeQuery ( querySQL ) ;

          while ( rs.next ( ) )
          {
        	found = true;
        	System.out.println(rs.getString("ndate")+ " " + rs.getString("time") + " " + rs.getString("description"));
        	          
          }
        }
        catch (SQLException e)
        {
          sqlCode = e.getErrorCode(); // Get SQLCODE
          sqlState = e.getSQLState(); // Get SQLSTATE  
          System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
          System.out.println(e);
        }
        System.out.println("\n");
        if (!found) System.out.print("No notes are found for this pregnancy");
		
	}

	private static void findApptDateSelection(Scanner command, int pracId2, Statement statement, int sqlCode, String sqlState) {
		ArrayList<Appointment> appts = new ArrayList<Appointment>();
		boolean EnotPressed = true;
		while (EnotPressed) {
    		System.out.println("Please enter the date for appointment list [E] to exit:");
    		String nl = command.nextLine();
    		if (nl.equals("E")) EnotPressed = false;
    		else appts = findAppointmentDate(command, nl, pracId, statement, sqlCode, sqlState);
    		if (appts != null && appts.size() != 0) break;
    		if (appts == null) {
    		System.out.println("You have no appointments for that day\n");
    		}
    	}
	}

	private static ArrayList<Appointment> findAppointmentDate(Scanner command, String date, int wife_id, Statement statement, int sqlCode, String sqlState) {
		
		// Querying a table
		ArrayList<Appointment> result = new ArrayList<Appointment>();
		boolean found = false;
        try
        {
          String querySQL = "SELECT hcardid, name, time, isPrimary, appt_id, pregnancy_id "
          		+ "FROM MOTHERS m, "
          		+ "(SELECT p.parents_id, time, isPrimary, appt_id, p.pregnancy_id "
          		+ "FROM PREGNANCY p, "
          		+ "(SELECT a.appt_id, a.pregnancy_id, time, isPrimary "
          		+ "FROM APPOINTMENTS a, "
          		+ "(SELECT pregnancy_id, isPrimary FROM ASSIGNEDWIVES aw WHERE aw.wife_id = "+wife_id+") aw "
          		+ "WHERE adate = '"+ date + "' AND a.pregnancy_id = aw.pregnancy_id) ap "
          		+ "WHERE ap.pregnancy_id = p.pregnancy_id) ai "
          		+ "WHERE m.mother_id = ai.parents_id;";
          
          java.sql.ResultSet rs = statement.executeQuery ( querySQL ) ;

          while ( rs.next ( ) )
          {
        	found = true;
        	result.add(new Appointment(rs.getString("time"),
        			rs.getString("name"), rs.getString("hcardid"),
        			rs.getInt("appt_id"), rs.getBoolean("isPrimary"),
        			rs.getInt("pregnancy_id"))); 
          }
        }
        catch (SQLException e)
        {
          sqlCode = e.getErrorCode(); // Get SQLCODE
          sqlState = e.getSQLState(); // Get SQLSTATE
            
          System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
          System.out.println(e);
        }
        if (found) {  
        	printAppointments(result);
        	return selectOption(result, command, pracId, statement, sqlCode, sqlState);
        	} 
        else return null;
		
	}

	private static void printAppointments(ArrayList<Appointment> result) {
		
		int count = 1;
		for (Appointment a : result) {
			String isP = "P";
			if(a.isPrimary() == false) isP = "B";
			System.out.println(count + ":	"+a.getTime()+" "+isP+"	 "+ a.getName() +" "+a.getHcardid());
			count++;
		}
	}

	private static int findPractitionerId(String wifeId, Statement statement, int sqlCode, String sqlState) {
		// Querying a table
		boolean found = false;
		int id = 0;
        try
        {
          String querySQL = "SELECT wife_id, name " + "FROM Midwife WHERE wife_id LIKE '"+wifeId+"'" ;
          java.sql.ResultSet rs = statement.executeQuery ( querySQL ) ;

          while ( rs.next ( ) )
          {
        	found = true;  
            id = rs.getInt ( 1 ) ;
          }
        }
        catch (SQLException e)
        {
          sqlCode = e.getErrorCode(); // Get SQLCODE
          sqlState = e.getSQLState(); // Get SQLSTATE
            
          System.out.println("Code: " + sqlCode + "  sqlState: " + sqlState);
          System.out.println(e);
        }
        if (found) return id; 
        return -1;
	}

}
