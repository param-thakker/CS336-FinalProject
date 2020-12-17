<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Add Customer Representative</title>
	</head>
	<body style="background-color:powderblue;">
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String SSN = request.getParameter("SSN");
			String FirstName = request.getParameter("FirstName");
			String LastName = request.getParameter("LastName");
			String Username = request.getParameter("Username");
			String Password = request.getParameter("Password");
			String StationID = request.getParameter("StationID");
			//Make a DELETE query from the table specified by the 'command' parameter at the index.jsp
			String str1 = "SELECT Username FROM EmployeeWorksAt WHERE Username = '"+Username+"'";
			String str = "REPLACE INTO EmployeeWorksAt VALUES  ("+StationID+", '"+SSN+"', '"+LastName+"', '"+FirstName+"', '"+Username+"', '"+Password+"')";
			//Run the update against the database.
			ResultSet result = stmt.executeQuery(str1);
			if(!result.next()){
				stmt.executeUpdate(str);
				out.print("Success!");
			}else
				out.print("Duplicate Username");
			//close the connection.
			db.closeConnection(con);
			%>
			
		<form action="adminPage.jsp">
         <button type="submit">Home</button>
      	</form>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>