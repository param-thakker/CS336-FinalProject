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
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			Date cur = new java.util.Date();
			String current = "'"+cur.toString().substring(24,28)+"-"+ (cur.getMonth()+1) + "-" + (cur.getDate()+1)+"'";
			String loggedInUser = (String) session.getAttribute("user");
			loggedInUser="Username";
			String str = "SELECT * FROM ResPassTransLine WHERE Username = '"+loggedInUser+"'";
			//Run the query against the database.
			ResultSet result1 = stmt.executeQuery(str);
			ResultSet result = stmt.executeQuery(str);
			
			
		%>
		
		Select a reservation to delete(Current Reservations): 
		<form method="get" action="deleteReservation.jsp">
		<table>
		<tr>    
			<td>Select</td>
			<td>Reservation Number</td>
			<td>Reservation Date</td>
			<td>Name</td>
			<td>Origin</td>
			<td>Destination</td>
			<td>Departure Time</td>
			<td>Price</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<%if(true){ %>
				<tr>    
				<td><input type="radio" name="tripToDelete" value="<%= result.getString("Reservation_Number") %>"/></td>
					<td><%= result.getString("Reservation_Number") %></td>
					<td><%= result.getString("Reservation_Date") %></td>					
					<td><%= result.getString("Transit_Line_Name") %></td>
					<td><%= result.getString("Origin") %></td>
					<td><%= result.getString("Destination") %></td>
					<td><%= result.getString("DepartureTime") %></td>
					<td><%= result.getString("Fare") %></td>
				</tr>
				<%}%>
			<%} %>
		</table>
			<input type="submit" value="Delete">
		</form>
		Past Reservations:
		<table>
		<tr>    
			<td>Reservation Number</td>
			<td>Reservation Date</td>
			<td>Name</td>
			<td>Origin</td>
			<td>Destination</td>
			<td>Departure Time</td>
			<td>Price</td>
		</tr>
			<%
			//parse out the results
			while (result.next()) { %>
				<%if(true){ %>
				<tr>    
					<td><%= result.getString("Reservation_Number") %></td>
					<td><%= result.getString("Reservation_Date") %></td>					
					<td><%= result.getString("Transit_Line_Name") %></td>
					<td><%= result.getString("Origin") %></td>
					<td><%= result.getString("Destination") %></td>
					<td><%= result.getString("DepartureTime") %></td>
					<td><%= result.getString("Fare") %></td>
				</tr>
				<%}%>
			<%}
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>