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
			String customerName= request.getParameter("reservationName");
			String[] nameSplit=customerName.split("\\s+");
			String First_Name=nameSplit[0];
			String Last_Name=nameSplit[1];
			//Get the combobox from the index.jsp
		//	String entity = request.getParameter("price");
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String str = "SELECT r.Reservation_Number Reservation_Number,r.Reservation_Date Reservation_Date,r.Fare Fare,r.Username Username,r.Transit_Line_Name Transit_Line_Name,r.Origin Origin,r.Destination Destination,r.DepartureTime DepartureTime, r.ReturnTime ReturnTime FROM ResPassTransLine r, Customer c WHERE c.First_Name=" + "'" + First_Name + "'" + " AND c.Last_Name="
					+ "'" + Last_Name + "'" + " AND c.Username=r.Username" ;
		

			//sort by month according to o.g. doc


			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			
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