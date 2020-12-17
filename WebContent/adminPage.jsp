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

				  
<b><u>CUSTOMER REPRESENTATIVES</u></b>
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
				
		
				out.print("</tr>");
			}
			out.print("</table>");
			%>
			<br>
			<b>Edit A Customer Representative</b>
			<br>
			Enter the SSN of the Representative and Select a Attribute
			<br>
			<form method="get" action="editCustomerRep.jsp">
			<input type="text" name="SSN" placeholder="123456789"/>
				<select name="Attribute" placeholder="Username"> 
					<option name="FirstName" value="FirstName">First Name</option>
  					<option name="LastName" value="LastName">Last Name</option>
					<option name="Username" value="Username">Username</option>
					<option name="Password" value="Password">Password</option>
					<option name="StationID" value="StationID">StationID</option>
				</select>
				 <input type="submit" name="editRep" value="Edit Customer Rep" />
			</form>
			<% 
			%>
			<br>
			<b>Add a Customer Rep</b>
			<br>
			Enter the info of the Representative
			<br>
			<form method="get" action="addCustomerRep.jsp">
			Enter SSN <input type="text" name="SSN" placeholder="123456789"/>
			<br>
			Enter First Name <input type="text" name="FirstName" placeholder="John"/>
			<br>
			Enter Last Name <input type="text" name="LastName" placeholder="Wick"/>
			<br>
			Enter Username <input type="text" name="Username" placeholder="Username"/>
			<br>
			Enter Password <input type="password" name="Password" placeholder="Password"/>
			<br>
			Enter StationID of the Station<input type="text" name="StationID" placeholder="StationID"/>
			<br>
			<input type="submit" name="addRep" value="Add Customer Rep" />
			</form>
			<br>
			<b>Delete A Customer Representative</b>
			<br>
			Enter the SSN of the Representative to be removed from the Database
			<br>
			<form method="post" action="deleteCustomerRep.jsp">
			<input type="text" name="SSN" placeholder="123456789"/>
			 <input type="submit" name="deleteRep" value="Delete" />
			 </form>
			<%
			//close the connection.
			db.closeConnection(con);
			con.close();
		} catch (Exception e) {
		}
	%>
<br>
<br>





<b><u>SALES REPORT</u></b>
<br>
<br>
See sales report per month:
<form method="get" action="salesReport.jsp">
 <select name="month" placeholder="">
  <option name="January" value="January">January</option>
  <option name="February" value="February">February</option>
  <option name="March" value="March">March</option>
  <option name="April" value="April">April</option>
	<option name="May" value="May">May</option>
  <option name="June" value="June">June</option>
  <option name="July" value="July">July</option>
  <option name="August" value="August">August</option>
	<option name="September" value="September">September</option>
  <option name="October" value="October">October</option>
  <option name="November" value="November">November</option>
  <option name="December" value="December">December</option>
</select> <input type="submit" value="Search" />



</form>
<br>



	
<b><u>RESERVATIONS</u></b>
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



<b><u>REVENUE</u></b>
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




<b><u>BEST CUSTOMER</u></b>
<br>
<br>
<form method="get" action="getBestCustomer.jsp">
Click to see the best customer: <input type="submit" name="bestCustomer" value="Search" />
<br>
</form>
<br>



<b><u>5 Most Active Transit Lines</u></b>
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