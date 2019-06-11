select * from [dbo].[Employee_Roster_Data];
select * from [dbo].skills;
select * from [dbo].hours;

ALTER TABLE [dbo].hours
ADD	total_working_hours_per_week INT;

UPDATE hours
SET total_working_hours_per_week = 40;
COMMIT;

ALTER TABLE hours
ADD  bClientHrs1 DECIMAL,
  bClientHrs2 DECIMAL,
  bClientHrs3 DECIMAL,
  bAdminHrs1 DECIMAL,
  bAdminHrs2 DECIMAL,
  bAdminHrs3 DECIMAL;

UPDATE hours 
SET bClientHrs1 = CAST(ClientHrs1 AS DECIMAL),
bClientHrs2 = CAST(ClientHrs2 AS DECIMAL),
bClientHrs3 = CAST(ClientHrs3 AS DECIMAL),
bAdminHrs1 = CAST(AdminHrs1 AS DECIMAL),
bAdminHrs2 = CAST(AdminHrs2 AS DECIMAL),
bAdminHrs3 = CAST(AdminHrs3 AS DECIMAL);
COMMIT;

ALTER TABLE hours DROP COLUMN ClientHrs1;
ALTER TABLE hours DROP COLUMN ClientHrs2;
ALTER TABLE hours DROP COLUMN ClientHrs3;
ALTER TABLE hours DROP COLUMN AdminHrs1;
ALTER TABLE hours DROP COLUMN AdminHrs2;
ALTER TABLE hours DROP COLUMN AdminHrs3;

EXEC sp_RENAME 'hours.bClientHrs1' , 'ClientHrs1', 'COLUMN';
EXEC sp_RENAME 'hours.bClientHrs2' , 'ClientHrs2', 'COLUMN';
EXEC sp_RENAME 'hours.bClientHrs3' , 'ClientHrs3', 'COLUMN';
EXEC sp_RENAME 'hours.bAdminHrs1' , 'AdminHrs1', 'COLUMN';
EXEC sp_RENAME 'hours.bAdminHrs2' , 'AdminHrs2', 'COLUMN';
EXEC sp_RENAME 'hours.bAdminHrs3' , 'AdminHrs3', 'COLUMN';

ALTER TABLE [dbo].hours
ADD	utilization INT;

UPDATE hours
SET utilization = CASE WHEN AdminHrs1+AdminHrs2+AdminHrs3 = 0
					THEN 0
				 ELSE ((ClientHrs1+ClientHrs2+ClientHrs3)/(AdminHrs1+AdminHrs2+AdminHrs3))
				 END;
COMMIT;

ALTER TABLE [dbo].hours
ADD	client_time DECIMAL;

UPDATE hours
SET admin_time = CASE WHEN ClientHrs1+ClientHrs2+ClientHrs3+AdminHrs1+AdminHrs2+AdminHrs3 != 0
					THEN ((AdminHrs1+AdminHrs2+AdminHrs3) / (ClientHrs1+ClientHrs2+ClientHrs3+AdminHrs1+AdminHrs2+AdminHrs3))*100
				 ELSE 0
				 END;

ALTER TABLE [dbo].hours
ADD	admin_time DECIMAL;

UPDATE hours
SET admin_time = (adminHours / totalWorkingHours)*100;
COMMIT;


ALTER TABLE [dbo].skills
ADD	skills_level VARCHAR(20);

UPDATE skills
SET skills_level =CASE WHEN Attribute_Level = 0
					THEN 'WANTS TO LEARN'
					WHEN Attribute_Level BETWEEN 1 AND 2
					THEN 'HEAVY SUPERVISION'
					WHEN Attribute_Level BETWEEN 3 AND 4
					THEN 'LIGHT SUPERVISION'
					WHEN Attribute_Level = 5
					THEN 'EXPERT'
					ELSE 'UNKNOWN'
					END;
COMMIT;