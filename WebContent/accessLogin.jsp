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
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			Boolean isLoggedIn = (Boolean) session.getAttribute("user");
			isLoggedIn = isLoggedIn != null && isLoggedIn;
			if (isLoggedIn) {
				out.print("You are logged in!");
			} else if (!isLoggedIn && username == null) {
				response.sendRedirect(request.getContextPath() + "/login.jsp");
			} else {
				//out.print("extra 2");
				//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
				String str = "SELECT * FROM Accounts";
				
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
	
				boolean isIn=false;
				while(result.next())
					if (!(result.getString("username")==null)&&result.getString("username").equals(username))
						if (!(result.getString("password")==null)&&result.getString("password").equals(password))
							isIn=true;
				if (isIn){
					session.setAttribute("user", true);
					out.print("Login Successful");
				}
				else{
					out.print("Login Failed");
				}
			}
			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
	<form action="logout.jsp" method="GET">
    	<button>logout</button>
	</form>


	
</body>
</html>