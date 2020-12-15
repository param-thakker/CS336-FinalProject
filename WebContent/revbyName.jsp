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
			String customerName= request.getParameter("revenueCustomer");		
			String[] nameSplit=customerName.split("\\s+");
			String First_Name=nameSplit[0];
			String Last_Name=nameSplit[1];
			String str = "SELECT ROUND(sum(Fare),2) as Revenue FROM ResPassTransLine r, Customer c WHERE c.First_Name='" + First_Name + "' AND c.Last_Name='"
					+ Last_Name + "' AND c.Username=r.Username" ;
			
			
			//sort by month according to o.g. doc


			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			out.print("<table border=2>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("Revenue by " + customerName );
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
				out.print(result.getString("Revenue"));
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