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
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String trainLine = request.getParameter("trainLine");
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM TransitLine";
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
		%>
		
		Stops: 
		<table>
		<tr>    
			<td>Name</td>
			<td>Departure Time</td>
			<td>Arrival Time</td>
			<td>Price</td>
			<td>Time</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<tr>    
				<td><input type="radio" name="selectedTrip" value="<%= result.getString("Transit_Line_Name") %>"/></td>
					<td><%= result.getString("Transit_Line_Name") %></td>
					<td><%= result.getString("DepartureTime") %></td>
					<td><%= result.getString("ArrivalTime") %></td>
					<td><%= result.getString("Fare") %></td>
					<td><%= result.getString("TravelTime") %></td>
				</tr>
				

			<% }
			//close the connection.
			db.closeConnection(con);
			%>
		</table>

		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>