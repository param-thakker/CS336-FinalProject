CREATE DATABASE IF NOT EXISTS TRAIN;
USE TRAIN;
CREATE TABLE IF NOT EXISTS Station(
				StationID int primary key,
				StationName varchar(30),
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
                foreign key(StationID) references Station(StationID)
);
CREATE TABLE IF NOT EXISTS TransitLine(
				Transit_Line_Name varchar(20) primary key,
                Origin varchar(50),
                Destination varchar(50),
                ArrivalTime datetime,
                DepartureTime datetime,
                Train_Number int,
                Fare float,
                TravelTime int
);
CREATE TABLE IF NOT EXISTS hasStop(
				Transit_Line_Name varchar(20),
                StationID int,
                Fare float,
                Departure datetime,
                Arrival datetime,
                primary key (Transit_Line_Name, StationID),
				foreign key (Transit_Line_Name) references TransitLine(Transit_Line_Name),
                foreign key (StationID) references Station(StationID)
);
CREATE TABLE IF NOT EXISTS TrainPartOf(
				TrainID int primary key,
				Transit_Line_Name varchar(20),
                foreign key (Transit_Line_Name) references TransitLine(Transit_Line_Name)
);
CREATE TABLE IF NOT EXISTS Accounts(
				Email varchar(50),
				Password varchar(50),
                LastName varchar(20),
                FirstName varchar(20),
                Username varchar(50),
                Usertype varchar(20),
                primary key(Username)         
);
CREATE TABLE IF NOT EXISTS ResPassTransLine(
				Reservation_Number int,
                Reservation_Date date,
				Username varchar(20),
                Transit_Line_Name varchar(20),
                Origin varchar(50),
                Destination varchar(50),
                DepartureTime datetime,
                Fare float,
                primary key(Reservation_Number),
                foreign key (Transit_Line_Name) references TransitLine(Transit_Line_Name),
                foreign key (Username) references Accounts(Username)
);
CREATE TABLE IF NOT EXISTS Questions(
				Question varchar(50),
                Answer varchar(50),
                primary key(Question)
);