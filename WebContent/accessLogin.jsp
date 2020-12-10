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
				//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
				//String str = "SELECT * FROM Accounts WHERE username = " + username + " and password ";
				String str = "SELECT * FROM Accounts";

				//Run the query against the database.
				ResultSet result = stmt.executeQuery(str);
	
				String isIn="";
				while(result.next())
					if (!(result.getString("username")==null)&&result.getString("username").equals(username))
						if (!(result.getString("password")==null)&&result.getString("password").equals(password))
							isIn=result.getString("userType");
				if (!(isIn.equals(""))){
					session.setAttribute("user", true);
					out.print("Login Successful");
					if (isIn.equals("admin"))//////change this later once admin name/user types have be
						response.sendRedirect(request.getContextPath() + "/adminPage.jsp");
					else if (isIn.equals("rep"))//////change this later once admin name/user types have been implemented
						response.sendRedirect(request.getContextPath() + "/repPage.jsp");
					else if (isIn.equals("customer"))//////change this later once admin name/user types have been implemented
						response.sendRedirect(request.getContextPath() + "/custPage.jsp");
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