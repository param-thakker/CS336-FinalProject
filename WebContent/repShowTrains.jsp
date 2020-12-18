<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Train Details</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			String entity = request.getParameter("command");

			//Get the selected radio button from the index.jsp
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			int stationID =0;
			if (session.getAttribute("stationID")==null){
				stationID = Integer.parseInt(request.getParameter("station"));
				session.setAttribute("stationID", stationID);
				session.setAttribute("orOrDest", entity);
			} else {
				stationID = (Integer)session.getAttribute("stationID");
				entity = (String)session.getAttribute("orOrDest");

			}

			
			String str="";
			if (entity.equals("origin")){
				str = "SELECT t.Transit_Line_Name transitline, t.DepartureTime dep, t.ArrivalTime arr"
						+ " FROM TransitLine t WHERE t.OriginStationID = '" + stationID + "'";
			} else if (entity.equals("destination")){
				str = "SELECT t.Transit_Line_Name transitline, t.DepartureTime dep, t.ArrivalTime arr"
						+ " FROM TransitLine t WHERE t.DestinationStationID = '" + stationID + "'";

			}
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			//close the connection.
			
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("TL");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Arrival Time");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Departure Time");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("transitline"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("arr"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("dep"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");

			db.closeConnection(con);
			con.close();

		%>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	
	<form method="post" action="repShowDetailTrains.jsp">
	<br>
		Other Stops on TrainLine: <input type="text" name="trainline">
		<br>
	<input type="submit" value="Commit">
	</form>
	<br>
	
	<form action="repPage.jsp" method="GET">
    	<button>Back</button>
	</form>
	

	</body>
</html>