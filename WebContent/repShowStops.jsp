<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Stops For Trainline</title>
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
		//	String entity = request.getParameter("trainline");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String trainLine = (String)session.getAttribute("trainline");

			String getTrainSchedule = "SELECT s.StationID id, s.StationName name, h.Fare fare, h.Arrival arr, h.Departure dep " +
					"FROM hasStop h, Station s WHERE Transit_Line_Name = '"+trainLine+"' and s.StationID = h.StationID ORDER BY arr ASC";
			
			ResultSet result = stmt.executeQuery(getTrainSchedule);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			out.print("stationID");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("nameStop");
			out.print("</td>");
			//make a column
			/*out.print("<td>");
			out.print("Fare");
			out.print("</td>");*/
			//make a column
			out.print("<td>");
			out.print("ArrivalTime");
			out.print("</td>");
			
			out.print("<td>");
			out.print("DepartureTime");
			out.print("</td>");
			
			out.print("<td>");

			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				out.print(result.getString("id"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("name"));
				out.print("</td>");
				/*out.print("<td>");
				out.print(result.getFloat("fare"));
				out.print("</td>");*/
				
				out.print("<td>");
				out.print(result.getTimestamp("arr"));
				out.print("</td>");
				out.print("<td>");
				out.print(result.getTimestamp("dep"));
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
	<form method="post" action="repEditStops.jsp">
			  <input type="radio" name="command" value="update"/> Edit Stop
			  <br>
			  <input type="radio" name="command" value="add"/> Add Stop
			  <br>
		  <input type="radio" name="command" value="delete"/>Delete Stop (only Station parameter needed)
		    <!-- when the radio for bars is chosen, then 'command' will have value 
		     | 'bars', in the show.jsp file, when you access request.parameters -->
		  <br>
		

	<table>
	<tr>
	<td>StationID</td><td><input type="text" name="station"></td>
	</tr>
	<tr>
	<td>Departure</td><td><input type="text" name="depart"> (Again, format is yyyy-mm-dd hh:mm:ss)</td>
	</tr>
	<tr>
	<td>Arrival</td><td><input type="text" name="arrive"></td>
	</tr>
	</table>
	<input type="submit" value="Commit">
	</form>
	<br>

	
	<form action="repEditLine.jsp" method="GET">
    	<button>Back</button>
	</form>

</body>
</html>