<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
    <%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
    
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Admin Home</title>
	</head>
<body style="background-color:powderblue;">

							  
<br>


<br>
<br>

	
RESERVATIONS
Make a New Reservation and View Train Schedules
<br>
<br>
<form method="get" action="showCustomerSearch.jsp">

 Origin: <input type="text" name="originStation" placeholder="New Brunswick"/> 
   <br>
  Destination: <input type="text" name="destinationStation" placeholder="Matawan"/> 
  <br>
  Date of Travel (YYYY/MM/DD): <input type="text" name="dateOfTravel" placeholder="2020-12-10"/> 
  <br>
  <input type="submit" value="Search" />
</form>
<br>

View Current and Past Reservations:
<br>
<br>
<form method="get" action="manageReservations.jsp">
	<button type="submit">Manage</button>
</form>
<br>

TRAIN INFO
<br>
<br>
<form method="get" action="showTrainStops.jsp">

 Train Line: <input type="text" name="trainLine" placeholder="Raritan Valley"/> 
   <br>
  <input type="submit" value="See Stops" />
</form>
<br>
	
QUESTIONS/FEEDBACK
<br>
<br>
<form method="get" action="insertQuestion.jsp">

 Enter a question: <input type="text" name="question" placeholder="How do I make a reservation?"/> 
   <br>
  <br>
  <input type="submit" value="Submit" />
</form>
<br>
<form action="logout.jsp" method="GET">
    	<button>logout</button>
	</form>

</body>
</html>