<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Customer Reservations shown</title>
	</head>
	<body>
		<% try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			//Get the selected radio button from the index.jsp
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String TL = request.getParameter("TL");
			String date = request.getParameter("date");
		    

			String str = "SELECT Username FROM ResPassTransLine WHERE Transit_Line_Name = '" + TL + "' and CAST(DepartureTime AS DATE) = CAST('"+date+"' AS DATE)";
			//SELECT Username, Reservation_Number FROM ResPassTransLine WHERE Transit_Line_Name = 'Garden'  and CAST(DepartureTime AS DATE) = CAST('2020-12-11' AS DATE);
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			//close the connection.
			
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("usernames");
			out.print("</td>");
			//make a column
			/*out.print("<td>");
			out.print("beer");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("price");
			out.print("</td>");*/
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("Username"));
				out.print("</td>");
				/*out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("password"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("email"));
				out.print("</td>");*/
				out.print("</tr>");

			}
			out.print("</table>");
			//out.print(str);

			db.closeConnection(con);

		%>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
	<form action="repPage.jsp" method="GET">
    	<button>Back</button>
	</form>
	

	</body>
</html>