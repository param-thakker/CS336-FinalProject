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
			
			
			
			//sort by month according to o.g. doc
			String month = request.getParameter("month");
			String str = "SELECT ROUND(sum(Fare),2) as TotalRevenue FROM ResPassTransLine r WHERE MONTHNAME(Reservation_Date) = " + "'" + month + "'";
//" + month as Month+

			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			out.print("<table border=2>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("Sales report for " + month);
			%><br><br><% 
			out.print("<td>");
			//print out column header
			out.print("TotalRevenue");
			out.print("</td>");
			out.print("</tr>");
			//out.print("<td>");
				//Print out current bar name:
				//out.print(result.getString("Month"));
				//out.print("</td>");
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				
				out.print("<td>");
				//Print out current bar name:
				out.print("$");
				out.print(result.getString("TotalRevenue"));
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