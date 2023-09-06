SELECT *
FROM PortfolioProject..MyDermaClinicLiposculpture

-- Standarizing date format

SELECT sale_dateConverted, CONVERT(DATE,sale_date)
FROM PortfolioProject..MyDermaClinicLiposculpture

UPDATE MyDermaClinicLiposculpture
SET sale_date = CONVERT(DATE,sale_date)

ALTER TABLE MyDermaClinicLiposcuplture
ADD sale_dateConverted DATE;

UPDATE MyDermaClinicLiposculpture
SET sale_dateConverted = CONVERT(DATE,sale_date)


-- Populate Contact Name and Email (Remove NULL emails)

SELECT a.contact_name, a.email, b.contact_name, b.email, ISNULL(a.email,b.email)
FROM PortfolioProject..MyDermaClinicLiposculpture a
JOIN PortfolioProject..MyDermaClinicLiposculpture b
  ON a.contact_name = b.contact_name
  AND a.[phone ] <> b.[phone ]
WHERE a.email is null


UPDATE a
SET email = ISNULL(a.email,b.email)
FROM PortfolioProject..MyDermaClinicLiposcuplture a
JOIN PortfolioProject..MyDermaClinicLiposculpture b
  ON a.contact_name = b.contact_name
  AND a.[phone ] <> b.[phone ]
WHERE a.email is null


-- Breaking out Full name into Individual Columns (Name, Last Name)

SELECT contact_name
FROM PortfolioProject..MyDermaClinicLiposculpture

SELECT
SUBSTRING(contact_name, 1, CHARINDEX(' ', contact_name)) as Name,
SUBSTRING(contact_name, CHARINDEX(' ', contact_name), LEN(contact_name)) as Last_Name
FROM PortfolioProject..MyDermaClinicLiposculpture

-- Example of the use of CHARINDEX

SELECT CHARINDEX(' ', contact_name)
FROM PortfolioProject..MyDermaClinicLiposculpture


-- Adding new Name and Last Name columns to the table

ALTER TABLE MyDermaClinicLiposculpture
ADD Name NVARCHAR(50);

UPDATE MyDermaClinicLiposculpture
SET Name = SUBSTRING(contact_name, 1, CHARINDEX(' ', contact_name))

ALTER TABLE MyDermaClinicLiposculpture
ADD Last_Name NVARCHAR(50);

UPDATE MyDermaClinicLiposculpture
SET Last_Name = SUBSTRING(contact_name, CHARINDEX(' ', contact_name), LEN(contact_name))


-- Change to a boolean (Y/N) answer in "Status" field
-- Here you'll see the 4 Stages of the funnel: Open, Lost, Abandoned, and Won

SELECT DISTINCT(status)
FROM PortfolioProject..MyDermaClinicLiposculpture

-- Here you'll see the amount of leads on each status/stages of the funnel

SELECT DISTINCT(status), COUNT(status)
FROM PortfolioProject..MyDermaClinicLiposculpture
GROUP BY status
ORDER BY 2

-- Changing the status to just 3 options

SELECT status,
CASE WHEN status = 'won' then 'YES'
     WHEN status = 'lost' then 'NO'
	 WHEN status = 'abandoned' then 'NO'
	 WHEN status = 'open' then 'OPEN'
	 ELSE status
	 END

-- Updating the columns

UPDATE PortfolioProject..MyDermaClinicLiposculpture
SET status = CASE WHEN status = 'won' then 'YES'
     WHEN status = 'lost' then 'NO'
	 WHEN status = 'abandoned' then 'NO'
	 WHEN status = 'open' then 'OPEN'
	 ELSE status
	 END
FROM PortfolioProject..MyDermaClinicLiposculpture


-- Removing unused columns 


SELECT *
FROM PortfolioProject..MyDermaClinicLiposculpture

ALTER TABLE PortfolioProject..MyDermaClinicLiposculpture
DROP COLUMN assigned, date_added, sale_date

