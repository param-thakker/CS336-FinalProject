<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Manage Reservations</title>
	</head>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String ResNumber = request.getParameter("tripToDelete");
			//Make a DELETE query from the table specified by the 'command' parameter at the index.jsp
			String str = "DELETE FROM ResPassTransLine WHERE Reservation_Number = "+ResNumber;
			//Run the update against the database.
			stmt.executeUpdate(str);
			//close the connection.
			db.closeConnection(con);
			%>
			Success!
		<form action="manageReservations.jsp">
         <button type="submit">Back</button>
      	</form>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>