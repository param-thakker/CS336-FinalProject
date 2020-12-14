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
			String loggedInUser = (String) session.getAttribute("user");
			if (loggedInUser != null) {
				out.print("You are logged in!");
			} else if (loggedInUser == null && username == null) {
				response.sendRedirect(request.getContextPath() + "/login.jsp");
			} else {
				//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
				//String str = "SELECT * FROM Accounts WHERE username = " + username + " and password ";
				String str = "SELECT * FROM Accounts WHERE Username='" + username + "' AND Password='" + password + "'";
				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
				if (result.next()) {
					String isIn = result.getString("Usertype");
					session.setAttribute("user", username);
				
					if (isIn.equals("admin"))
						response.sendRedirect(request.getContextPath() + "/adminPage.jsp");
					else if (isIn.equals("rep"))
						response.sendRedirect(request.getContextPath() + "/repPage.jsp");
					else
						response.sendRedirect(request.getContextPath() + "/custPage.jsp");
				}
				else {
					response.sendRedirect(request.getContextPath() + "/login.jsp");
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