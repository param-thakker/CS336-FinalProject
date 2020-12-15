<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Insert title here</title>
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
			String transitLine = request.getParameter("reservationLine");
			String str = "SELECT * FROM ResPassTransLine r WHERE r.Transit_Line_Name =" + "'" + transitLine + "'";  //*


			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);
			
			//close the connection.
			
			out.print("<table border=2>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Reservation_Number");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Reservation_Date");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Fare");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Username");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Transit_Line_Name");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Origin");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("Destination");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("DepartureTime");
			out.print("</td>");
			out.print("<td>");
			//print out column header
			out.print("ReturnTime");
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
				out.print(result.getString("Reservation_Number"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("Reservation_Date"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("Fare"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("Username"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("Transit_Line_Name"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("Origin"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("Destination"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("DepartureTime"));
				out.print("</td>");
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("ReturnTime"));
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
	
	
	<br>
	
	<button type="button" name="back" onclick="history.back()"> Back </button>
	

	</body>
</html>