CREATE TABLE Employee_Roster_Data
	(User_ID varchar(1000),
	Email_ID varchar(1000),
	Title varchar(1000),
	Fullname varchar(1000),
	Department varchar(1000),
	Gender varchar(1000),
	Office varchar(1000),
	Region varchar(1000),
	Tenure_Yrs varchar(1000),
	Seniority varchar(1000),
	Salary varchar(1000),
	Currency varchar(1000),
	Rating varchar(1000),
	Survey_Score varchar(1000),
	Promotion varchar(1000),
	Avg_Hrs varchar(1000));

CREATE TABLE skills
(UserId varchar(1000),
Fullname varchar(1000),
Department varchar(1000),
Gender varchar(1000),
Attribute_Group varchar(1000),
Attribute_Sub_Group varchar(1000),
Attribute_Type varchar(1000),
Attribute_Name varchar(1000),
Attribute_Level varchar(1000),
Attribute_Verified varchar(1000));

CREATE TABLE hours
(Date varchar(1000),
UserId varchar(1000),
AdminHrs1 varchar(1000),
AdminHrs2 varchar(1000),
AdminHrs3 varchar(1000),
ClientHrs1 varchar(1000),
ClientHrs2 varchar(1000),
ClientHrs3 varchar(1000),
TargetClientHrs varchar(1000));

CREATE TABLE Email_Data
(from_ID int,
to_ID int);

SELECT COUNT(*) FROM Email_Data;
SELECT COUNT(*) FROM hours;
SELECT COUNT(*) FROM skills;
SELECT COUNT(*) FROM Employee_Roster_Data;