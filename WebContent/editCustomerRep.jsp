<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Edit Customer Rep</title>
	</head>
	<body style="background-color:powderblue;">
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String Attribute = request.getParameter("Attribute");
			String SSN = request.getParameter("SSN");
			String NewValue = request.getParameter("NewValue");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			if(Attribute.equals("StationID")){
				String str = "UPDATE EmployeeWorksAt SET "+Attribute+"="+NewValue+" WHERE SSN='"+SSN+"'";
				
				stmt.executeUpdate(str);
			}
			else{
				String str = "UPDATE EmployeeWorksAt SET "+Attribute+"='"+NewValue+"' WHERE SSN='"+SSN+"'";
			
				stmt.executeUpdate(str);				
			}
		%>
			
		<!--  Make an HTML table to show the results in: -->
		<br>
		Enter New Value for this Attribute:
		<form method="get" action="editCustomerRep.jsp">
		<% 
			if(Attribute.equals("Password"))
				out.print("<input type=\"password\" name=\"NewValue\" placeholder = \"\"/>");
			else
				out.print("<input type=\"text\" name=\"NewValue\" placeholder = \"\"/>");
		%>
		<input type="hidden" name="Attribute" value="<%= Attribute %>">
		<input type="hidden" name="SSN" value="<%= SSN %>">
		<input type="submit" value="Submit">
		</form>
<form action="adminPage.jsp">
		<input type="submit" value="Back">
		</form>
	

		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>