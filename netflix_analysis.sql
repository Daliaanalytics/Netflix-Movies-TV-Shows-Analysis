CREATE DATABASE NetflixDB;
GO

USE NetflixDB;
GO

CREATE TABLE Netflix(
    show_id NVARCHAR(10),
    type NVARCHAR(10),
    title NVARCHAR(200),
    director NVARCHAR(200),
    cast NVARCHAR(MAX),
    country NVARCHAR(200),
    date_added NVARCHAR(50),
    release_year INT,
    rating NVARCHAR(20),
    duration NVARCHAR(20),
    listed_in NVARCHAR(200),
    description NVARCHAR(MAX)
);

BULK INSERT Netflix
FROM 'C:\Users\MKcomputer\Documents\Netflix_Movies_and_TV_Shows\netflix_clean.csv'
WITH(
     FIRSTROW=2,
	 FIELDTERMINATOR= '\t' ,
	 ROWTERMINATOR= '0x0a',
	 TABLOCK
);

DROP TABLE Netflix;

TRUNCATE TABLE Netflix;

BULK INSERT Netflix
FROM 'C:\Users\MKcomputer\Documents\Netflix_Movies_and_TV_Shows\netflix_clean.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

TRUNCATE TABLE Netflix;

BULK INSERT Netflix
FROM 'C:\Users\MKcomputer\Documents\Netflix_Movies_and_TV_Shows\netflix_clean.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    FIELDQUOTE = '"',
    TABLOCK
);

DROP TABLE Netflix;

CREATE TABLE Netflix (
    show_id NVARCHAR(10),
    type NVARCHAR(10),
    title NVARCHAR(200),
    director NVARCHAR(200),
    cast NVARCHAR(MAX),
    country NVARCHAR(200),
    date_added NVARCHAR(50),
    release_year NVARCHAR(10),
    rating NVARCHAR(20),
    duration NVARCHAR(20),
    listed_in NVARCHAR(200),
    description NVARCHAR(MAX)
);

BULK INSERT Netflix
FROM 'C:\Users\MKcomputer\Documents\Netflix_Movies_and_TV_Shows\netflix_clean.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = '\t',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    FIELDQUOTE = '"',
    TABLOCK
);

USE NetflixDB;
GO

SELECT COUNT(*) AS Total_rows FROM Netflix;

SELECT TOP 5 show_id, type, title, country, release_year FROM Netflix;

SELECT type,
       COUNT(*) AS total,
	   ROUND(COUNT(*)*100/(SELECT COUNT(*) FROM Netflix),2) AS Percentage
FROM Netflix
GROUP BY type;

SELECT TOP 5 * FROM Netflix;

SELECT TOP 10 country,
       COUNT(*) AS total_content
FROM Netflix
WHERE country != 'Unknown'
GROUP BY country
ORDER BY total_content DESC;

SELECT release_year,
       COUNT(*) AS total_content,
	   SUM(CASE WHEN type= 'Movie' THEN 1 ELSE 0 END) AS Movies,
	   SUM(CASE WHEN type='TV Show' THEN 1 ELSE 0 END) AS TV_shows
FROM Netflix
WHERE release_year>=2010
GROUP BY release_year
ORDER BY release_year;

SELECT rating,
       COUNT(*) AS total,
	   ROUND(COUNT(*)*100/ (SELECT COUNT(*) FROM Netflix),2) AS Percentage
FROM Netflix
GROUP BY rating
ORDER BY total DESC;

SELECT TOP 10 listed_in,
       COUNT(*) AS total
FROM Netflix
GROUP BY listed_in
ORDER BY total DESC;