<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
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

		String trainLine = request.getParameter("trainline");
		String param = request.getParameter("param");
		String value = request.getParameter("value");

		//Make an insert statement for the Sells table:
		String editTrainSchedule="";
			if (entity.equals("update")){
				editTrainSchedule = "UPDATE TransitLine SET " + param + " = ? WHERE Transit_Line_Name = ?";
				PreparedStatement ps = con.prepareStatement(editTrainSchedule);
				if (param.equals("OriginStationID")|| param.equals("DestinationStationID")){
					int ID=Integer.parseInt(value);
					ps.setInt(1, ID);
					
					String getCount = "SELECT count(*) count FROM hasStop WHERE Transit_Line_Name = '" + trainLine + "' and "
							+ "StationID = "+ID;
					
					ResultSet countSet = stmt.executeQuery(getCount);

					countSet.next();
					int exist=(countSet.getInt("count"));
					if (exist == 0){
						if (param.equals("OriginStationID")){
							String getTime = "SELECT DepartureTime FROM TransitLine WHERE Transit_Line_Name = '" + trainLine + "'";
							ResultSet destSet = stmt.executeQuery(getTime);
							destSet.next();
							try{
									java.sql.Timestamp DT = destSet.getTimestamp("DepartureTime");
									if (DT!=null){
										editTrainSchedule = "INSERT INTO hasStop (Transit_Line_Name, StationID, Departure) VALUES (?,?,?)";
										PreparedStatement insertOrigin = con.prepareStatement(editTrainSchedule);
										insertOrigin.setString(1, trainLine);
										insertOrigin.setInt(2, ID);
										insertOrigin.setTimestamp(3, DT);
										insertOrigin.executeUpdate();
										
	//deals with fare..									
	String getCountforFare = "SELECT count(*) count FROM hasStop WHERE Transit_Line_Name = '" + trainLine + "'";
										
										ResultSet countSetforFare = stmt.executeQuery(getCountforFare);

										countSetforFare.next();
										int count=(countSetforFare.getInt("count"));

										
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

									}else{
										editTrainSchedule = "INSERT INTO hasStop (Transit_Line_Name, StationID) VALUES (?,?)";
										PreparedStatement insertOrigin = con.prepareStatement(editTrainSchedule);
										insertOrigin.setString(1, trainLine);
										insertOrigin.setInt(2, ID);
										insertOrigin.executeUpdate();

	//deals with fare..									
	String getCountforFare = "SELECT count(*) count FROM hasStop WHERE Transit_Line_Name = '" + trainLine + "'";
										
										ResultSet countSetforFare = stmt.executeQuery(getCountforFare);

										countSetforFare.next();
										int count=(countSetforFare.getInt("count"));

										
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

									}	
							} catch (Exception e){
								
							}
						}else {//this is a  Destination Node.
							String getTime = "SELECT ArrivalTime FROM TransitLine WHERE Transit_Line_Name = '" + trainLine + "'";
							ResultSet arrSet = stmt.executeQuery(getTime);
							arrSet.next();
							try{
									java.sql.Timestamp AT = arrSet.getTimestamp("ArrivalTime");
									if (AT!=null){
										editTrainSchedule = "INSERT INTO hasStop (Transit_Line_Name, StationID, Arrival) VALUES (?,?,?)";
										PreparedStatement insertOrigin = con.prepareStatement(editTrainSchedule);
										insertOrigin.setString(1, trainLine);
										insertOrigin.setInt(2, ID);
										insertOrigin.setTimestamp(3, AT);
										insertOrigin.executeUpdate();
	//deals with fare..									
	String getCountforFare = "SELECT count(*) count FROM hasStop WHERE Transit_Line_Name = '" + trainLine + "'";
										
										ResultSet countSetforFare = stmt.executeQuery(getCountforFare);

										countSetforFare.next();
										int count=(countSetforFare.getInt("count"));

										
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
									}else{
										editTrainSchedule = "INSERT INTO hasStop (Transit_Line_Name, StationID) VALUES (?,?)";
										PreparedStatement insertOrigin = con.prepareStatement(editTrainSchedule);
										insertOrigin.setString(1, trainLine);
										insertOrigin.setInt(2, ID);
										insertOrigin.executeUpdate();
										
	//deals with fare..									
	String getCountforFare = "SELECT count(*) count FROM hasStop WHERE Transit_Line_Name = '" + trainLine + "'";
										
										ResultSet countSetforFare = stmt.executeQuery(getCountforFare);

										countSetforFare.next();
										int count=(countSetforFare.getInt("count"));

										
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

									}
							} catch (Exception e){
								
							}
						}

					}
				}
				
				
				else if (param.equals("ArrivalTime")|| param.equals("DepartureTime")){
					java.sql.Timestamp timestamp = java.sql.Timestamp.valueOf(value);
					ps.setTimestamp(1, timestamp);
					
					if (param.equals("DestinationTime")){
						String getCount = "SELECT OriginStationID FROM TransitLine WHERE Transit_Line_Name = '" + trainLine + "'";
						ResultSet countSet = stmt.executeQuery(getCount);

						countSet.next();
						try{
							if (!countSet.isClosed()){
								int ID=countSet.getInt("OriginStationID");
								editTrainSchedule = "UPDATE hasStop SET Departure = ? WHERE Transit_Line_Name = ? and StationID = ?";
								PreparedStatement insertOrigin = con.prepareStatement(editTrainSchedule);
								insertOrigin.setTimestamp(1, timestamp);
								insertOrigin.setString(2, trainLine);
								insertOrigin.setInt(3, ID);
								insertOrigin.executeUpdate();
							}

						}catch (Exception e){
							
						}

					}else{
						
							String getCount = "SELECT DestinationStationID FROM TransitLine WHERE Transit_Line_Name = '" + trainLine + "'";
							ResultSet countSet = stmt.executeQuery(getCount);

							countSet.next();
							try{
								if (!countSet.isClosed()){
									int ID=countSet.getInt("DestinationStationID");
									editTrainSchedule = "UPDATE hasStop SET Arrival = ? WHERE Transit_Line_Name = ? and StationID = ?";
									PreparedStatement insertOrigin = con.prepareStatement(editTrainSchedule);
									insertOrigin.setTimestamp(1, timestamp);
									insertOrigin.setString(2, trainLine);
									insertOrigin.setInt(3, ID);
									insertOrigin.executeUpdate();
								}

							}catch (Exception e){
								
							}
					}
					
				}
				else if (param.equals("Train_Number")|| param.equals("TravelTime")){
					int val = Integer.parseInt(value);
					ps.setInt(1, val);
				}
				else if (param.equals("Fare")){
					float fare = Float.parseFloat(value);
					ps.setFloat(1, fare);
					
					String getCount = "SELECT count(*) FROM hasStop WHERE Transit_Line_Name = '" + trainLine + "'";
					
					ResultSet countSet = stmt.executeQuery(getCount);

					countSet.next();
					if (countSet.getFloat("count(*)")>0){
						String updateFare = "UPDATE hasStop SET Fare = ?" 
							+ " WHERE Transit_Line_Name = ?";
					
						PreparedStatement fareS = con.prepareStatement(updateFare);
	
						fareS.setFloat(1, fare/countSet.getFloat("count(*)"));
						fareS.setString(2, trainLine);
	
						fareS.executeUpdate();
					}

				}

				ps.setString(2, trainLine);
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.executeUpdate();

			} else if (entity.equals("delete")){
				editTrainSchedule = "DELETE FROM TransitLine WHERE Transit_Line_Name = ?";
				PreparedStatement ps = con.prepareStatement(editTrainSchedule);
				ps.setString(1, trainLine);
				ps.executeUpdate();

			
			} else if (entity.equals("add")){
				editTrainSchedule = "INSERT INTO TransitLine (Transit_Line_Name) VALUES (?)";//doesnt format...
				PreparedStatement ps = con.prepareStatement(editTrainSchedule);
				ps.setString(1, trainLine);
				//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
				ps.executeUpdate();

			}else if (entity.equals("addStops")){
				session.setAttribute("trainline", trainLine);
				response.sendRedirect(request.getContextPath() + "/repShowStops.jsp");
			}
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query

		//Run the query against the DB
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("edit succeeded");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("edit failed");
	}
%>

	<button type="button" name="back" onclick="window.location.reload(history.back())">Return to Train Schedules</button>

</body>
</html>