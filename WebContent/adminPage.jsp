<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<h2 style="text-align:center">Admin's Page</h2>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Admin Home</title>
	</head>
<body style="background-color:powderblue;">

				  
<b>CUSTOMER REPRESENTATIVES</b>
<br><br>

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
			String str = "SELECT StationID,SSN,FirstName,LastName FROM EmployeeWorksAt ORDER BY StationID";
			//String getTrainSchedule = "SELECT * FROM TransitLine";
			
			//Run the query against the database.
			ResultSet result = stmt.executeQuery(str);

			//Make an HTML table to show the results in:
			out.print("<table border=2>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("StationID");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("SSN");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("FirstName");
			out.print("</td>");
			out.print("<td>");
			out.print("LastName");
			out.print("</td>");
			/*out.print("<td>");
			out.print("Edit");
			out.print("</td>");
			out.print("<td>");
			out.print("Delete");
			out.print("</td>");*/
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current bar name:
				out.print(result.getString("StationID"));
				out.print("</td>");
				out.print("<td>");
				//Print out current beer name:
				out.print(result.getString("SSN"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("FirstName"));
				out.print("</td>");
				out.print("<td>");
				//Print out current price
				out.print(result.getString("LastName"));
				out.print("</td>");
				
				out.print("<td>");
				
	%>			<form method="get" action="getBestCustomer.jsp">
				 <input type="submit" name="bestCustomer" value="Edit" />
				 </form>
				<% out.print("</td>");
				out.print("<td>");
				%>
				<form method="get" action="getBestCustomer.jsp">
				 <input type="submit" name="bestCustomer" value="Delete" />
				 </form>
				<% 	out.print("</td>");

				out.print("</tr>");

			}
			out.print("</table>");
			%>
			<br>
			<form method="get" action="getBestCustomer.jsp">
				 <input type="submit" name="bestCustomer" value="Add Customer Rep" />
				 </form>
			<% 



			//close the connection.
			db.closeConnection(con);
			con.close();

		} catch (Exception e) {
		}
	%>
<br>





<b>SALES REPORT</b>
<br>
<br>
See sales report per month:
<form method="get" action="salesReport.jsp">
 <select name="month" placeholder="">
  <option name="January" value="Jan">January</option>
  <option name="February" value="Feb">February</option>
  <option name="March" value="Mar">March</option>
  <option name="April" value="Apr">April</option>
	<option name="May" value="May">May</option>
  <option name="June" value="Jun">June</option>
  <option name="July" value="Jul">July</option>
  <option name="August" value="Aug">August</option>
	<option name="September" value="Sep">September</option>
  <option name="October" value="Oct">October</option>
  <option name="November" value="Nov">November</option>
  <option name="December" value="Dec">December</option>
</select> <input type="submit" value="Search" />



</form>
<br>



	
<b>RESERVATIONS</b>
<br>
<br>
<form method="get" action="resbyTL.jsp">

 See reservations by transit line: <input type="text" name="reservationLine" placeholder="transit line"/> <input type="submit" value="Search" />
   <br>
   </form>
   <form method="get" action="resbyName.jsp">
  See reservations by name: <input type="text" name="reservationName" placeholder="customer name"/> <input type="submit" value="Search" />
 
  <br>
  </form>
  

<br>



<b>REVENUE</b>
<br>
<br>
	<form method="get" action="revbyTL.jsp">
	 Calculate revenue per transit line: <input type="text" name="revenueLine" placeholder="transit line"/> <input type="submit" value="Calculate" />
     <br>
     </form>
      <form method="get" action="revbyName.jsp">
     Calculate revenue per customer: <input type="text" name="revenueCustomer" placeholder="customer name"/> <input type="submit" value="Calculate" />
 
  <br>
	</form>
<br>




<b>BEST CUSTOMER</b>
<br>
<br>
<form method="get" action="getBestCustomer.jsp">
Click to see the best customer: <input type="submit" name="bestCustomer" value="Search" />
<br>
</form>
<br>



<b>5 Most Active Transit Lines</b>
<br>
<br>
<form method="get" action="fiveMostActive.jsp">
Click to see the 5 Most Active Transit Lines: <input type="submit" name="fiveMostActive" value="Search" />
<br>
</form>
<br>
<br>
	<form action="logout.jsp" method="GET">
    	<button>logout</button>
	</form>
</body>
</html>