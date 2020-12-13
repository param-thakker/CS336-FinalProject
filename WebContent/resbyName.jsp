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
		out.print("THIS IS THE ADMIN PAGE");
	%>
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
			String str = "SELECT r.Reservation_Number,r.Reservation_Date,r.Fare,r.Username,r.Transit_Line_Name,r.Origin,r.Destination,r.DepartureTime FROM ResPassTransLine r, Customer c WHERE c.First_Name=" + First_Name + " AND c.Last_Name="
					+ Last_Name + " AND c.Username=r.Username" ;
		

			//sort by month according to o.g. doc


			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			
			//Make an HTML table to show the results in:
			/*out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("user");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("pw");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("email");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("pw");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("username"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("password"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("email"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("userType"));
				out.print("</td>");

				out.print("</tr>");

			}
			out.print("</table>");*/

			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
	
	<form action="logout.jsp" method="GET">
    	<button>Logout</button>
	</form>
</body>
</html>