<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Inserting Reservation</title>
	</head>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			String selectedTrip = request.getParameter("selectedTrip");
			String discounted = request.getParameter("discounted");
			String tripType = request.getParameter("tripType");
			String origin = request.getParameter("originStation");
			String destination = request.getParameter("destinationStation");
			String date = request.getParameter("dateOfTravel");
			String returnDate = request.getParameter("dateOfReturn");
			String loggedInUser = (String) session.getAttribute("user");
			loggedInUser="Username";
			String round;
			if(tripType.equals("round"))
				round = request.getParameter("selectedReturnTrip");
			else
				round = "placeholder";
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			ResultSet result;
			String str1;
			if(tripType.equals("round"))
				str1 = "SELECT * FROM TransitLine WHERE Origin='"+origin+"' AND Destination='"+destination+"' AND CAST(DepartureTime AS DATE) = '"+returnDate+"'";
			else 
				str1 = "SELECT * FROM TransitLine WHERE Origin='"+origin+"' AND Destination='"+destination+"'";
			result = stmt.executeQuery(str1);
			//Run the query against the database.
			String resID = java.util.UUID.randomUUID().toString();
			String str;
			if(!round.equals("placeholder")){				
				if(discounted.equals("true"))
					str = "REPLACE INTO ResPassTransLine VALUES ('"+resID+"', '"+date+"', (SELECT Fare FROM TransitLine WHERE Transit_Line_Name = '"+selectedTrip+"')+(SELECT Fare FROM TransitLine WHERE Transit_Line_Name = '"
						+round+"')-2, '" +loggedInUser+"', '"+selectedTrip+"', '"+round+"', '"+origin+"', '"
						+destination+"', '"+date+"', '"+returnDate+"');";
				else
					str = "REPLACE INTO ResPassTransLine VALUES ('"+resID+"', '"+date+"', (SELECT Fare FROM TransitLine WHERE Transit_Line_Name = '"+selectedTrip+"')+(SELECT Fare FROM TransitLine WHERE Transit_Line_Name = '"
						+round+"'), '" +loggedInUser+"', '"+selectedTrip+"', '"+round+"', '"+origin+"', '"
						+destination+"', '"+date+"', '"+returnDate+"');";
				stmt.executeUpdate(str);
			} else {
				if(discounted.equals("true"))
					str = "REPLACE INTO ResPassTransLine VALUES ('"+resID+"', '"+date+"', (SELECT Fare FROM TransitLine WHERE Transit_Line_Name = '"+selectedTrip+"')-2, '" +loggedInUser+"', '"+selectedTrip+"', null, '"+origin+"', '"
						+destination+"', '"+date+"', null);";
				else
					str = "REPLACE INTO ResPassTransLine VALUES ('"+resID+"', '"+date+"', (SELECT Fare FROM TransitLine WHERE Transit_Line_Name = '"+selectedTrip+"'), '" +loggedInUser+"', '"+selectedTrip+"', null, '"+origin+"', '"
						+destination+"', '"+date+"', null);";
				stmt.executeUpdate(str);
			}
		%>
			
		<!--  Make an HTML table to show the results in: -->
		
		If Round Trip Pick a Train: 
		<form method="get" action="makeReservation.jsp">
		<table>
		<tr>    
			<td>Select</td>
			<td>Name</td>
			<td>Departure Time</td>
			<td>Arrival Time</td>
			<td>Price</td>
			<td>Time</td>
		</tr>
			<%
			//parse out the results
			if(tripType.equals("round")){
				while (result.next()) { %>
				<tr>    
				<td><input type="radio" name="selectedReturnTrip" value="<%= result.getString("Transit_Line_Name") %>"/></td>
					<td><%= result.getString("Transit_Line_Name") %></td>
					<td><%= result.getString("DepartureTime") %></td>
					<td><%= result.getString("ArrivalTime") %></td>
					<td><%= result.getString("Fare") %></td>
					<td><%= result.getString("TravelTime") %></td>
				</tr>
			<% }}
			//close the connection.
			db.closeConnection(con);
			%>
		</table>
		<input type="submit" value="Make a reservation">
		</form>	
		
		<form action="showCustomerSearch.jsp">
         <button type="submit">Back</button>
      	</form>
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>