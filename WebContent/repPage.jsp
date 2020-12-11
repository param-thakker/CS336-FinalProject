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
			String str = "SELECT * FROM Accounts";
			String getTrainSchedule = "SELECT * FROM TransitLine";
			
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
				out.print(result.getString("Origin"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("Destination"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");
			
			
			
			String questions = "SELECT * FROM Questions";
			
			//Run the query against the database.
			result = stmt.executeQuery(questions);

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
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("Question"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("Answer"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("???"));
				out.print("</td>");
				out.print("</tr>");

			}
			out.print("</table>");


			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
	<br>
	<form method="post" action="editLineRep.jsp">
			  <input type="radio" name="command" value="update"/>Update
			  <br>
		  <input type="radio" name="command" value="delete"/>Delete (only TrainLine parameter is needed)
		    <!-- when the radio for bars is chosen, then 'command' will have value 
		     | 'bars', in the show.jsp file, when you access request.parameters -->
		  <br>
		

	<table>
	<tr>
	<td>TrainLine</td><td><input type="text" name="row"></td>
	</tr>
		<tr>
	<td>Parameter</td><td><input type="text" name="param"></td>
	</tr>
	<tr>
	<td>Value</td><td><input type="text" name="value"></td>
	</tr>
	</table>
	<input type="submit" value="Commit">
	</form>
	<br>
	
	
	<form method="post" action="answerQuestionRep.jsp">
	<br>
		Q: <input type="text" name="question">
		<br>
		A: <input type="text" name="answer">
		<br>
	<input type="submit" value="Commit">
	</form>
	<br>

	<form method="post" action="showTrainsRep.jsp">
	  Produce list of all train schedules containing
    <br>
	Station: <input type="text" name="station">
    <br>
	<input type="submit" value="Commit">
	</form>
	<br>
	
	<form method="post" action="showCustsRep.jsp">
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