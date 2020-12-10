<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
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
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String email = request.getParameter("email");
	//	out.print("Checkpoint 1\n");

		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO Accounts(email, password, username, userType)"
				+ "VALUES (?, ?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);
	//	out.print("Checkpoint 2\n");

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, email);
		ps.setString(2, password);
		ps.setString(3, username);
		ps.setString(4, "customer");
		//Run the query against the DB
	//	out.print("Checkpoint 3\n");
		ps.executeUpdate();

		//Run the query against the DB
	//	out.print("Checkpoint 4\n");

		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("New User Successfully Created");
	}catch (Exception e){
		out.print(e);
		out.print("New User Could Not Be Created");
	}%>
</body>
</html>