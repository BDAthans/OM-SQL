/* 
SQL Query updates all eDocuments that are missing the file path in the EDocLink Attribute of table dbo.eDocuments
NOTE: Update the @DataDir variable so that point to the eDocuments folder, and DO NOT end the DataDir with a \.
This does not update any files that already include any pathing to the file. 
This query only updates the EDocLinks that are only the filename.
*/

DECLARE @oldDocLink nvarchar(255);
DECLARE @DataDir nvarchar(1000);
DECLARE @docCount int = 0;
SET @DataDir = '\\SERVER\Officemate\data\eDocuments';

WHILE (SELECT COUNT(*) FROM eDocuments WHERE EDocLink LIKE '[0-9]%.%'
OR EDocLink LIKE '[a-Z][a-Z]%.%' OR EDocLink LIKE '[a-Z][0-9]%.%') > 0
BEGIN

SELECT @oldDocLink = eDocuments.EDocLink
FROM eDocuments
WHERE EDocLink LIKE '[0-9]%.%'
OR EDocLink LIKE '[a-Z][a-Z]%.%'
OR EDocLink LIKE '[a-Z][0-9]%.%';

UPDATE eDocuments
SET EDocLink = @DataDir + '\' + @oldDocLink 
WHERE eDocuments.EDocLink = @oldDocLink;
print('Current DocLink = ' + @oldDocLink);
print('Updated EDocLink = ' + @DataDir + @oldDocLink);
SET @docCount += 1;
END
print('');
print('Count of EDoclinks fixed below');
print(@docCount);
-- Might want to add logging function about what values were before and after update in loop
