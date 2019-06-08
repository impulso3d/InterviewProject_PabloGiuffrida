import json
import requests
import pyodbc

import pandas as pd
from pandas import ExcelWriter
#from pandas import ExcelFile4


conn = pyodbc.connect('Driver={SQL Server};'
                      'Server=NERGAL;'
                      'Database=rga;'
                      'Trusted_Connection=yes;')
cursor = conn.cursor()	

df = pd.read_excel('InterviewProject_PabloGiuffrida/datasources/Employee_Roster_Data.xlsx', sheet_name='Sheet1')

for i in df.index:
	salaryCurr = df['Currency'][i]
	api_url_base = "http://data.fixer.io/api/2017-04-03?access_key=e5df4e23b970b4329b1c271794145444&&symbols=USD," + salaryCurr + "&format=1"
	response = requests.get(api_url_base)
	if response.status_code == 200:
		 data=json.loads(response.content.decode('utf-8'))
	
	salary = (df['Salary'][i] / data['rates'][salaryCurr] )* data['rates']['USD']
	
	currency = "USD"

	insertQuery = "INSERT INTO Employee_Roster_Data_USD(User_ID,Email_ID,Title,Fullname,Department,Gender,Office,Region,Tenure_Yrs,Seniority,Salary,Currency,Rating,Survey_Score,Promotion,Avg_Hrs)VALUES('"+ str(df['User_ID'][i])+"','"+str(df['Email_ID'][i])+"','"+str(df['Title'][i])+"','"+str(df['Fullname'][i])+"','"+str(df['Department'][i])+"','"+str(df['Gender'][i])+"','"+str(df['Office'][i])+"','"+str(df['Region'][i])+"','"+str(df['Tenure_Yrs'][i])+"','"+str(df['Seniority'][i])+"','"+ str(salary) +"','"+str(currency)+"','"+str(df['Rating'][i])+"','"+str(df['Survey_Score'][i])+"','"+str(df['Promotion'][i])+"','"+str(df['Avg_Hrs'][i])+"')"
	
	print(insertQuery)
	cursor.execute(insertQuery)
	conn.commit()