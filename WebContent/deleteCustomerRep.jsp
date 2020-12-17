<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
	</head>
	<body style="background-color:powderblue;">
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			String SSN = request.getParameter("SSN");
			//Get the selected radio button from the index.jsp
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			
			
			String str = "DELETE FROM EmployeeWorksAt WHERE SSN='" + SSN + "'";


			
			stmt.executeUpdate(str);
			out.print("Deleted Successfully");
			
			

			db.closeConnection(con);
			con.close();

		%>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	
	
	<br>
	
	<form action="adminPage.jsp">
		<input type="submit" value="Back">
		</form>
	

	</body>
</html>