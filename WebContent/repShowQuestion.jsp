<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question Answer session</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		String questions = "SELECT * FROM Questions";
		
		//Run the query against the database.
		ResultSet result = stmt.executeQuery(questions);


		//Make an HTML table to show the results in:
		out.print("<table>");

		//make a row
		out.print("<tr>");
		//make a column
		out.print("<td>");
		//print out column header
		out.print("Question");
		out.print("</td>");
		//make a column
		out.print("<td>");
		out.print("Answer");
		out.print("</td>");
		//make a column
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
			out.print("</tr>");

		}
		out.print("</table>");


		//close the connection.
		con.close();
		db.closeConnection(con);


		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		
	} catch (Exception ex) {
		out.print(ex);
	}
%>

	<form method="post" action="repAnswerQuestion.jsp">
	<br>
		Q: <input type="text" name="question">
		<br>
		A: <input type="text" name="answer">
		<br>
	<input type="submit" value="Commit">
	</form>
	<br>

	<form action="repPage.jsp" method="GET">
    	<button>Back to Rep Page</button>
	</form>


</body>
</html>