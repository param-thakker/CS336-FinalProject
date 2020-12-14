
CREATE DATABASE IF NOT EXISTS TRAIN;
USE TRAIN;
CREATE TABLE IF NOT EXISTS Station(
				StationID int primary key,
				StationName varchar(30) not null,
                State varchar(20),
                City varchar(20)
);
CREATE TABLE IF NOT EXISTS EmployeeWorksAt(
				StationID int,
                SSN varchar(11),
                LastName varchar(20),
                FirstName varchar(20),
                Username varchar(20),
                Password varchar(20),
                primary key(SSN),
                foreign key(StationID) references Station(StationID) on update cascade
);
CREATE TABLE IF NOT EXISTS TransitLine(
				Transit_Line_Name varchar(20) primary key,
                Origin varchar(30),
                Destination varchar(30),
				DepartureTime datetime,
                ArrivalTime datetime,
                Train_Number int,
                Fare float,
                TravelTime int,
                OriginStationID int,
                DestinationStationID int,
                foreign key(OriginStationID) references Station (StationID) on update cascade,
				foreign key(DestinationStationID) references Station(StationID) on update cascade
);
CREATE TABLE IF NOT EXISTS hasStop(
				Transit_Line_Name varchar(20),
                StationID int,
                Fare float,
                Departure datetime,
                Arrival datetime,
                primary key (Transit_Line_Name, StationID),
				foreign key (Transit_Line_Name) references TransitLine(Transit_Line_Name) on update cascade,
                foreign key (StationID) references Station(StationID) on update cascade
);
CREATE TABLE IF NOT EXISTS TrainPartOf(
				TrainID int primary key,
				Transit_Line_Name varchar(20),
                foreign key (Transit_Line_Name) references TransitLine(Transit_Line_Name) on update cascade
);
CREATE TABLE IF NOT EXISTS Customer(
				Email varchar(50),
                Password varchar(50),
                First_Name varchar(20),
                Last_Name varchar(20),
                Username varchar(20) primary key
);
CREATE TABLE IF NOT EXISTS Accounts(
				First_Name varchar(50),
                Last_Name varchar(50),
				Email varchar(50),
				Password varchar(50),
                Username varchar(50),
                Usertype varchar(20),
                primary key(Username)
);
CREATE TABLE IF NOT EXISTS ResPassTransLine(
				Reservation_Number varchar(20),
                Reservation_Date date,
                Fare float,
				Username varchar(20),
                Transit_Line_Name varchar(20),
                Origin varchar(20),
                Destination varchar(20),
                DepartureTime datetime,
                primary key(Reservation_Number),	
                foreign key (Transit_Line_Name) references TransitLine(Transit_Line_Name) on update cascade,
                foreign key (Username) references Customer(Username) on update cascade
);
                
CREATE TABLE IF NOT EXISTS Questions(
				Question varchar(50),
                Answer varchar(50),
                primary key(Question));         

