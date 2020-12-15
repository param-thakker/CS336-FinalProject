<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		session.setAttribute("user", true);
		out.print("THIS IS THE REP PAGE");
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
			String str = "SELECT * FROM Station";
			//String getTrainSchedule = "SELECT * FROM TransitLine";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("bar");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("beer");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("price");
			out.print("</td>");
			out.print("<td>");
			out.print("city");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("StationId"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("StationName"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("State"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("City"));
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
	
	<form action="repShowTrainLine.jsp" method="GET">
    	<button>Edit Train Schedules</button>
	</form>
	
	
		<br>
	
	<form action="repShowQuestion.jsp" method="GET">
    	<button>Show Customer Questions</button>
	</form>
	

	<form method="post" action="repShowTrains.jsp">
	  Produce list of all train schedules
	  <br>
	  <input type="radio" name="command" value="origin"/>Originating at
	  <br>
	  <input type="radio" name="command" value="destination"/>Destined for
	    <br>
	StationID: <input type="text" name="station">
    <br>
	<input type="submit" value="Commit">
	</form>
	<br>
	
	<form method="post" action="repShowCusts.jsp">
		  Produce list of all customers for reservations on
	  <br>
		TransitLine: <input type="text" name="TL">
	  <br>
		Date: <input type="text" name="date">		
		<br>		
	<input type="submit" value="Commit">
	</form>
	<br>
	
	<form action="logout.jsp" method="GET">
    	<button>Logout</button>
	</form>
</body>
</html>