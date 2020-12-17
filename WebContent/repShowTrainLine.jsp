<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Trainline Details</title>
</head>
<body>
	<%
		session.setAttribute("user", true);
	%>
	<%
		List<String> list = new ArrayList<String>();

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the combobox from the index.jsp
		//	String entity = request.getParameter("price");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String getTrainSchedule = "SELECT * FROM TransitLine";
			
			ResultSet result = stmt.executeQuery(getTrainSchedule);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Transit_Line_Name");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("OriginStationID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("DestinationStationID");
			out.print("</td>");
			out.print("<td>");
			out.print("ArrivalTime");
			out.print("</td>");
			out.print("<td>");
			out.print("DepartureTime");
			out.print("</td>");
			out.print("<td>");
			out.print("Train_Number");
			out.print("</td>");
			out.print("<td>");
			out.print("Fare");
			out.print("</td>");
			out.print("<td>");
			out.print("TravelTime");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("Transit_Line_Name"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getInt("OriginStationID"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getInt("DestinationStationID"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getTimestamp("ArrivalTime"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getTimestamp("DepartureTime"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getInt("Train_Number"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getFloat("Fare"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getInt("TravelTime"));
				out.print("</td>");
				
				out.print("</tr>");

			}
			out.print("</table>");



			//close the connection.
			db.closeConnection(con);
			con.close();

		} catch (Exception e) {
		}
	%>
	<br>
		<br>
	<form method="post" action="repEditLine.jsp">
			  <input type="radio" name="command" value="update"/>Update
			  <br>
			  <input type="radio" name="command" value="add"/>Add (only TrainLine parameter is needed)
			  <br>
			  
		  <input type="radio" name="command" value="delete"/>Delete (only TrainLine parameter is needed)
		    <!-- when the radio for bars is chosen, then 'command' will have value 
		     | 'bars', in the show.jsp file, when you access request.parameters -->
		  <br>
		  	<input type="radio" name="command" value="addStops"/>Show Additional Stops for (only TrainLine parameter is needed)
			  <br>
	<table>
	<tr>
	<td>TrainLine</td><td><input type="text" name="trainline"></td>
	</tr>
		<tr>
	<td>Parameter</td><td><input type="text" name="param"> (Note that for times, format is yyyy-mm-dd hh:mm:ss)</td>
	</tr>
	<tr>
	<td>Value</td><td><input type="text" name="value"></td>
	</tr>
	</table>
	<input type="submit" value="Commit">
	</form>
	<br>

	
	<button type="button" name="back" onclick="history.back()"> Back </button>

</body>
</html>