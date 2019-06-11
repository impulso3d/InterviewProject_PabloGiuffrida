import pyodbc

import csv
import pandas as pd
from pandas import ExcelWriter
#from pandas import ExcelFile4


conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=NERGAL;'
                      'Database=rga;'
                      'Trusted_Connection=yes;')
cursor = conn.cursor()	

line = csv.reader(open('InterviewProject_PabloGiuffrida/datasources/Email_Data.txt', newline=''), delimiter='\t')
print("Starting emails table")

for row in line:
	if row[0] != 'from_ID': #avoiding header
		insertQuery = "INSERT INTO Email_Data(from_ID,to_ID)VALUES("+ (row[0])+","+(row[1])+")"
		
		cursor.execute(insertQuery)
		conn.commit()

df = pd.read_excel('InterviewProject_PabloGiuffrida/datasources/Employee_Roster_Data.xlsx', sheet_name='Sheet1')
print("Starting Employees table")

for i in df.index:

	insertQuery = "INSERT INTO Employee_Roster_Data(User_ID,Email_ID,Title,Fullname,Department,Gender,Office,Region,Tenure_Yrs,Seniority,Salary,Currency,Rating,Survey_Score,Promotion,Avg_Hrs)VALUES('"+ str(df['User_ID'][i])+"','"+str(df['Email_ID'][i])+"','"+str(df['Title'][i])+"','"+str(df['Fullname'][i]).replace("'", " ")+"','"+str(df['Department'][i])+"','"+str(df['Gender'][i])+"','"+str(df['Office'][i])+"','"+str(df['Region'][i])+"','"+str(df['Tenure_Yrs'][i])+"','"+str(df['Seniority'][i])+"','"+ str(df['Salary'][i]) +"','"+str(df['Currency'][i])+"','"+str(df['Rating'][i])+"','"+str(df['Survey_Score'][i])+"','"+str(df['Promotion'][i])+"','"+str(df['Avg_Hrs'][i])+"')"
	
	cursor.execute(insertQuery)
	conn.commit()	

df = pd.read_excel('InterviewProject_PabloGiuffrida/datasources/hours.xlsx', sheet_name='Sheet1')
print("Starting hours table")

for i in df.index:

	insertQuery = "INSERT INTO hours(Date,UserId,AdminHrs1,AdminHrs2,AdminHrs3,ClientHrs1,ClientHrs2,ClientHrs3,TargetClientHrs)VALUES	('"+ str(df['Date'][i])+"','"+str(df['UserId'][i])+"','"+str(df['AdminHrs1'][i])+"','"+str(df['AdminHrs2'][i])+"','"	+str(df['AdminHrs3'][i])+"','"+str(df['ClientHrs1'][i])+"','"+str(df['ClientHrs2'][i])+"','"+str(df['ClientHrs3'][i])+"','"+str(df['TargetClientHrs'][i])+"')"
	
	cursor.execute(insertQuery)
	conn.commit()	

df = pd.read_excel('InterviewProject_PabloGiuffrida/datasources/skills.xlsx', sheet_name='Sheet1')
print("Starting skills table")

for i in df.index:

	insertQuery = "INSERT INTO skills(UserId,Fullname,Department,Gender,Attribute_Group,Attribute_Sub_Group,Attribute_Type,Attribute_Name,Attribute_Level,Attribute_Verified)VALUES('"+ str(df['UserId'][i])+"','"+str(df['Fullname'][i]).replace("'", " ")+"','"+str(df['Department'][i])+"','"+str(df['Gender'][i])+"','"+str(df['Attribute Group'][i])+"','"+str(df['Attribute Sub-Group'][i])+"','"+str(df['Attribute Type'][i])+"','"+str(df['Attribute Name'][i])+"','"+str(df['Attribute Level'][i])+"','"+str(df['Attribute Verified'][i])+"')"
	
	cursor.execute(insertQuery)
	conn.commit()