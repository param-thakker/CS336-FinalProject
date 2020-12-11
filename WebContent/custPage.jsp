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


SALES REPORT
<br>
<br>

	
RESERVATIONS
<br>
<br>
<form method="get" action="show.jsp">

 Origin: <input type="text" name="originStation" placeholder="New Brunswick"/> 
   <br>
  Destination: <input type="text" name="destinationStation" placeholder="Matawan"/> 
  <br>
  Date of Travel (MM/DD/YYYY): <input type="text" name="dateOfTravel" placeholder="12/22/2020"/> 
  <br>
  <input type="submit" value="Search" />
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

</body>
</html>