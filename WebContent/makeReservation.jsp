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
	<body style="background-color:powderblue;">
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
			String completed = request.getParameter("secondTime");
			String round;
			java.util.Date cur = new java.util.Date();
			String current = cur.toString().substring(24,28)+"-"+ (cur.getMonth()+1) + "-" + (cur.getDate());
			if(tripType.equals("round"))
				round = request.getParameter("selectedReturnTrip");
			else
				round = "null";
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
			if(tripType.equals("round")){
				if(completed.equals("true")){
					if(discounted.equals("true"))
						str = "REPLACE INTO ResPassTransLine VALUES ('"+resID+"', '"+current+"', (SELECT Fare FROM TransitLine WHERE Transit_Line_Name = '"+selectedTrip+"')+(SELECT Fare FROM TransitLine WHERE Transit_Line_Name = '"
							+round+"')-2, '" +loggedInUser+"', '"+selectedTrip+"', '"+round+"', '"+origin+"', '"
							+destination+"', '"+date+"', '"+returnDate+"');";
					else
						str = "REPLACE INTO ResPassTransLine VALUES ('"+resID+"', '"+current+"', (SELECT Fare FROM TransitLine WHERE Transit_Line_Name = '"+selectedTrip+"')+(SELECT Fare FROM TransitLine WHERE Transit_Line_Name = '"
							+round+"'), '" +loggedInUser+"', '"+selectedTrip+"', '"+round+"', '"+origin+"', '"
							+destination+"', '"+date+"', '"+returnDate+"');";					
					stmt.executeUpdate(str);
				}
			} else {
				if(discounted.equals("true"))
					str = "REPLACE INTO ResPassTransLine VALUES ('"+resID+"', '"+current+"', (SELECT Fare FROM TransitLine WHERE Transit_Line_Name = '"+selectedTrip+"')-2, '" +loggedInUser+"', '"+selectedTrip+"', null, '"+origin+"', '"
						+destination+"', '"+date+"', null);";
				else
					str = "REPLACE INTO ResPassTransLine VALUES ('"+resID+"', '"+current+"', (SELECT Fare FROM TransitLine WHERE Transit_Line_Name = '"+selectedTrip+"'), '" +loggedInUser+"', '"+selectedTrip+"', null, '"+origin+"', '"
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
			if(tripType.equals("round")&&completed.equals("false")){
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
		 <input type="hidden" name="selectedTrip" value="<%= selectedTrip %>">
		  <input type="hidden" name="discounted" value="<%= discounted %>">
		  <input type="hidden" name="tripType" value="<%= tripType %>">
		  <input type="hidden" name="originStation" value="<%= origin %>">
		  <input type="hidden" name="destinationStation" value="<%= destination %>">
		  <input type="hidden" name="dateOfTravel" value="<%= date %>">
		  <input type="hidden" name="dateOfReturn" value="<%= returnDate %>">
		  <input type="hidden" name="selectedReturnTrip" value="<%= round %>">
		  <input type="hidden" name="secondTime" value="<%= "true" %>">
		<input type="submit" value="Make a reservation">
		</form>	
		
		<form action="custPage.jsp">
         <button type="submit">Home</button>
      	</form>
		<%} catch (Exception e) {
			out.print(e);
		}%>
	

	</body>
</html>