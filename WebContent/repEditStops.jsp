<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Editing Stops</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String entity = request.getParameter("command");

		String stationID = request.getParameter("station");
		String dep = request.getParameter("depart");
		String arr = request.getParameter("arrive");
		String trainLine = (String)session.getAttribute("trainline");

		//Make an insert statement for the Sells table:
		String editTrainSchedule="";
			if (entity.equals("update")){
				if (!arr.equals("") && !dep.equals("")){
					editTrainSchedule = "UPDATE hasStop SET Arrival = ? AND Departure = ? WHERE Transit_Line_Name = ? and StationID = ?";
					PreparedStatement ps = con.prepareStatement(editTrainSchedule);
					
					java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(arr);
					ps.setTimestamp(1, timestamp);
					java.sql.Timestamp depstamp = java.sql.Timestamp.valueOf(dep);
					ps.setTimestamp(2, depstamp);
				
					ps.setString(3, trainLine);
					ps.setString(4, stationID);

					ps.executeUpdate();
				} else if (!arr.equals("")){
					editTrainSchedule = "UPDATE hasStop SET Arrival = ? WHERE Transit_Line_Name = ? and StationID = ?";
					PreparedStatement ps = con.prepareStatement(editTrainSchedule);
					
					java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(arr);
					ps.setTimestamp(1, timestamp);
				
					ps.setString(2, trainLine);
					ps.setString(3, stationID);

					ps.executeUpdate();
				} else if (!dep.equals("")){
					editTrainSchedule = "UPDATE hasStop SET Departure = ? WHERE Transit_Line_Name = ? and StationID = ?";
					PreparedStatement ps = con.prepareStatement(editTrainSchedule);
					
					java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(dep);
					ps.setTimestamp(1, timestamp);
				
					ps.setString(2, trainLine);
					ps.setString(3, stationID);

					ps.executeUpdate();

				}
					

			} else if (entity.equals("delete")){
				editTrainSchedule = "DELETE FROM hasStop WHERE Transit_Line_Name = ? and StationID = ?";
				PreparedStatement ps = con.prepareStatement(editTrainSchedule);
				ps.setString(1, trainLine);
				ps.setString(2, stationID);
				ps.executeUpdate();

			
			} else if (entity.equals("add")){//both are nonempty
				if (arr.equals("")&&(dep.equals(""))){
					editTrainSchedule = "INSERT INTO hasStop (Transit_Line_Name, StationID) VALUES (?,?)";
					PreparedStatement ps = con.prepareStatement(editTrainSchedule);
					ps.setString(1, trainLine);
					ps.setString(2, stationID);
					ps.executeUpdate();
					
				} else if (!arr.equals("")&&(dep.equals(""))){//if only arr is nonempty
					editTrainSchedule = "INSERT INTO hasStop (Transit_Line_Name, StationID, Arrival) VALUES (?,?,?)";
					PreparedStatement ps = con.prepareStatement(editTrainSchedule);
					ps.setString(1, trainLine);
					ps.setString(2, stationID);
					java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(arr);
					ps.setTimestamp(3, timestamp);
					ps.executeUpdate();
					
				} else if (arr.equals("")&&!dep.equals("")){//if only dep is nonempty
					editTrainSchedule = "INSERT INTO hasStop (Transit_Line_Name, StationID, Departure) VALUES (?,?,?)";
					PreparedStatement ps = con.prepareStatement(editTrainSchedule);
					ps.setString(1, trainLine);
					ps.setString(2, stationID);
					java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(dep);
					ps.setTimestamp(3, timestamp);
					ps.executeUpdate();

				} else {
					editTrainSchedule = "INSERT INTO hasStop (Transit_Line_Name, StationID, Arrival, Departure) VALUES (?,?,?,?)";
					PreparedStatement ps = con.prepareStatement(editTrainSchedule);
					ps.setString(1, trainLine);
					ps.setString(2, stationID);
					java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(arr);
					ps.setTimestamp(3, timestamp);
					java.sql.Timestamp depStamp = java.sql.Timestamp.valueOf(dep);
					ps.setTimestamp(4, depStamp);

					ps.executeUpdate();

				}
			
				
				
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself

			}
			String getCount = "SELECT count(*) count FROM hasStop WHERE Transit_Line_Name = '" + trainLine + "'";
			
			ResultSet countSet = stmt.executeQuery(getCount);

			countSet.next();
			int count=(countSet.getInt("count"));

			
				String getFare = "SELECT fare FROM TransitLine WHERE Transit_Line_Name = '" + trainLine + "'";
				ResultSet fareSet=stmt.executeQuery(getFare);
				try{
					fareSet.next();
					//out.print( fareSet.getFloat("fare")+"fare");
					if ( (count>0) && fareSet.getFloat("fare")>=0.0){
						
						String updateFare = "UPDATE hasStop SET Fare = ?" 
							+ " WHERE Transit_Line_Name = ?";
					
						PreparedStatement fareS = con.prepareStatement(updateFare);

						fareS.setFloat(1, fareSet.getFloat("fare")/count);
						fareS.setString(2, trainLine);

						fareS.executeUpdate();
					}
				} catch (Exception e){
				}
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("edit succeeded");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("edit failed");
	}
%>

	<button type="button" name="back" onclick="window.location.reload(history.back())">Return to Train Schedule</button>

</body>
</html>