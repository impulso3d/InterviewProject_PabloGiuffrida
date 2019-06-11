CREATE SEQUENCE emp_dep_seq  
    START WITH 1 
    INCREMENT BY 1 ;  
	
create TABLE DIM_Employee_Department
(dw_emp_dep_id int primary key Default (Next Value For emp_dep_seq),
Department varchar(100));

CREATE SEQUENCE gender_seq  
    START WITH 1 
    INCREMENT BY 1 ;  
	
CREATE TABLE DIM_Employee_gender
(dw_gender_id int primary key  Default (Next Value For gender_seq),
gender varchar(100));

CREATE SEQUENCE users_seq  
    START WITH 1 
    INCREMENT BY 1 ;  
	
CREATE TABLE DIM_Users
(dw_user_id int primary key Default (Next Value For users_seq),
fullname varchar(100));

CREATE SEQUENCE currency_seq  
    START WITH 1 
    INCREMENT BY 1 ;  
	
CREATE TABLE DIM_Currency
(dw_currency_id int primary key Default (Next Value For currency_seq),
Currency varchar(100));

CREATE SEQUENCE att_group_seq  
    START WITH 1 
    INCREMENT BY 1 ;  
	
CREATE TABLE DIM_Attribute_Group
(dw_attribute_id int primary key Default (Next Value For att_group_seq),
Attribute varchar(100));

CREATE SEQUENCE att_sub_group_seq  
    START WITH 1 
    INCREMENT BY 1 ;  
	
CREATE TABLE DIM_Attribute_Sub_Group
(dw_att_sub_group_id int primary key Default (Next Value For att_sub_group_seq),
Attribute_Sub_Group varchar(100));

CREATE SEQUENCE att_type_seq  
    START WITH 1 
    INCREMENT BY 1 ;  
	
CREATE TABLE DIM_Attribute_Type
(dw_att_type_id int primary key Default (Next Value For att_type_seq),
Attribute_Type varchar(100));

CREATE SEQUENCE att_name_seq  
    START WITH 1 
    INCREMENT BY 1 ;  
	
CREATE TABLE DIM_Attribute_Name
(dw_att_name_id int primary key  Default (Next Value For att_name_seq),
Attribute_Name varchar(100));

INSERT INTO [dbo].[DIM_Attribute_Name] (Attribute_Name)
SELECT distinct Attribute_Name
FROM skills;

INSERT INTO [dbo].[DIM_Attribute_Sub_Group] (Attribute_Sub_Group)
SELECT distinct Attribute_Sub_Group
FROM skills;

INSERT INTO [dbo].[DIM_Attribute_Type] (Attribute_Type)
SELECT distinct Attribute_Type
FROM skills;

INSERT INTO [dbo].[DIM_Attribute_Group] (Attribute)
SELECT distinct Attribute_Group
FROM skills;

INSERT INTO DIM_Employee_gender(gender)
SELECT DISTINCT Gender 
FROM Employee_Roster_Data
UNION
SELECT DISTINCT Gender 
FROM skills;

INSERT INTO DIM_Currency(Currency)
SELECT DISTINCT Currency 
FROM Employee_Roster_Data;

INSERT INTO DIM_Employee_Department(Department)
SELECT DISTINCT Department 
FROM Employee_Roster_Data
UNION
SELECT DISTINCT Department 
FROM skills;

INSERT INTO DIM_Users(fullname)
SELECT DISTINCT fullname 
FROM Employee_Roster_Data
UNION
SELECT DISTINCT fullname 
FROM skills;

ALTER TABLE [dbo].[Employee_Roster_Data]
ADD dw_user_id INTEGER;

UPDATE Employee_Roster_Data
SET dw_user_id = (Select dw_user_id		
					from DIM_Users b
					where Employee_Roster_Data.fullname = b.fullname);

ALTER TABLE Employee_Roster_Data
ADD FOREIGN KEY (dw_user_id) REFERENCES DIM_Users(dw_user_id);

ALTER TABLE [dbo].[Employee_Roster_Data]
ADD dw_emp_dep_id INT
FOREIGN KEY (dw_emp_dep_id) REFERENCES DIM_Employee_Department(dw_emp_dep_id);

UPDATE Employee_Roster_Data
SET dw_emp_dep_id = (Select dw_emp_dep_id		
					from DIM_Employee_Department b
					where Employee_Roster_Data.Department = b.Department);

ALTER TABLE [dbo].[Employee_Roster_Data]
ADD dw_gender_id INT
FOREIGN KEY (dw_gender_id) REFERENCES [dbo].[DIM_Employee_gender](dw_gender_id);

UPDATE Employee_Roster_Data
SET dw_gender_id = (Select dw_gender_id		
					from [DIM_Employee_gender] b
					where Employee_Roster_Data.Gender = b.Gender);

ALTER TABLE [dbo].[Employee_Roster_Data]
ADD dw_currency_id INT
FOREIGN KEY (dw_currency_id) REFERENCES [dbo].DIM_Currency(dw_currency_id);

UPDATE Employee_Roster_Data
SET dw_currency_id = (Select dw_currency_id		
					from DIM_Currency b
					where Employee_Roster_Data.Currency = b.Currency);

ALTER TABLE [dbo].skills
ADD dw_user_id INT
FOREIGN KEY (dw_user_id) REFERENCES [dbo].DIM_Users(dw_user_id);

UPDATE skills
SET dw_user_id = (Select dw_user_id		
					from DIM_Users b
					where skills.fullname = b.fullname);

ALTER TABLE [dbo].skills
ADD dw_emp_dep_id INT
FOREIGN KEY (dw_emp_dep_id) REFERENCES [dbo].DIM_Employee_Department(dw_emp_dep_id);

UPDATE skills
SET dw_emp_dep_id = (Select dw_emp_dep_id		
					from DIM_Employee_Department b
					where skills.Department = b.Department);

ALTER TABLE [dbo].skills
ADD dw_gender_id INT
FOREIGN KEY (dw_gender_id) REFERENCES [dbo].[DIM_Employee_gender](dw_gender_id);

UPDATE skills
SET dw_gender_id = (Select dw_gender_id		
					from [DIM_Employee_gender] b
					where skills.Gender = b.Gender);

ALTER TABLE [dbo].skills
ADD dw_att_group_id INT
FOREIGN KEY (dw_att_group_id) REFERENCES [dbo].DIM_Attribute_Group(dw_attribute_id);

UPDATE skills
SET dw_att_group_id = (Select dw_attribute_id		
					from DIM_Attribute_Group b
					where skills.Attribute_Group = b.Attribute);

ALTER TABLE [dbo].skills
ADD dw_att_name_id INT
FOREIGN KEY (dw_att_name_id) REFERENCES [dbo].[DIM_Attribute_Name](dw_att_name_id);

UPDATE skills
SET dw_att_name_id = (Select dw_att_name_id		
					from [DIM_Attribute_Name] b
					where skills.Attribute_Name = b.Attribute_Name);

ALTER TABLE [dbo].skills
ADD [dw_att_sub_group_id] INT
FOREIGN KEY ([dw_att_sub_group_id]) REFERENCES [dbo].[DIM_Attribute_Sub_Group]([dw_att_sub_group_id]);

UPDATE skills
SET [dw_att_sub_group_id] = (Select [dw_att_sub_group_id]		
					from [DIM_Attribute_Sub_Group] b
					where skills.Attribute_Sub_Group = b.Attribute_Sub_Group);

ALTER TABLE [dbo].skills
ADD [dw_att_type_id] INT
FOREIGN KEY ([dw_att_type_id]) REFERENCES [dbo].[DIM_Attribute_Type]([dw_att_type_id]);

UPDATE skills
SET [dw_att_type_id] = (Select [dw_att_type_id]		
					from [DIM_Attribute_Type] b
					where skills.Attribute_Type = b.Attribute_Type);