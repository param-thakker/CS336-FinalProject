<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<h2>Admin's Page</h2>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Admin Home</title>
	</head>
<body style="background-color:powderblue;">

							  
<br>


SALES REPORT
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


   <br>



<br>
</form>
<br>
<br>

	
RESERVATIONS
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

REVENUE
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

<br>

BEST CUSTOMER
<br>
<br>
<form method="get" action="getBestCustomer.jsp">
Click to see the best customer: <input type="submit" name="bestCustomer" value="Search" />
<br>
</form>
<br>
<br>

5 Most Active Transit Lines
<br>
<br>
<form method="get" action="fiveMostActive.jsp">
Click to see the 5 Most Active Transit Lines: <input type="submit" name="fiveMostActive" value="Search" />
<br>
</form>
<br>
<br>

</body>
</html>