CREATE DATABASE mysql_project;

USE mysql_project;

LOAD DATA INFILE '/tmp/accounts.txt' INTO TABLE accounts
TERMINATED BY ','LINES TERMINATED BY '\r \n' IGNORE 1 LINES;

LOAD DATA INFILE '/tmp/videos.txt' INTO TABLE videos
TERMINATED BY ','LINES TERMINATED BY '\r \n' IGNORE 1 LINES;

LOAD DATA INFILE '/tmp/views.txt' INTO TABLE views
TERMINATED BY ','LINES TERMINATED BY '\r \n' IGNORE 1 LINES;

CREATE TABLE accounts (
	accountID INTEGER NOT NULL, 
	billID INTEGER(3),
	billAddress VARCHAR(30), 
	amount INTEGER(4)
);

CREATE TABLE videos (
	creatorName VARCHAR(30),
	videoName VARCHAR(50),
	link VARCHAR(20) NOT NULL,
	duration INTEGER(6),
	PRIMARY KEY(link)
);

CREATE TABLE views (
	accountID INTEGER NOT NULL,
	viewerName 	VARCHAR(50),
	link VARCHAR(20) NOT NULL,
	theTime VARCHAR(20),
	PRIMARY KEY(link)
);




-- Question 1: Account ID associate with the name Snowball Grottobow.

SELECT accountID
FROM views
WHERE viewerName='Snowball Grottobow';

-- Question 2: Show all the bills for the account found in 1.

SELECT billID
FROM accounts
WHERE accountID=5;

-- Question 3: Show all the video info for a provided link
-- -Video name, link, number of views

SELECT videos.videoName,videos.link,COUNT(views.accountID) AS numOfViews
FROM videos, views
WHERE (videos.link = views.link AND videos.link='bz4bnJ77um');

-- Question 4: Show all the videos created by the given elf,
-- with the total associated views

SELECT videos.videoName, views.accountID, COUNT(views.viewerName) AS numOfViews
FROM videos, views
WHERE (videos.link = views.link AND videos.creatorName='Snowball Grottobow');

-- Question 5: Find the videos for all Elves, where the
-- creator is the only viewer.

SELECT videos.videoName, videos.creatorName
FROM videos, views
WHERE (videos.creatorName = views.viewerName);

-- Question 6: Print a report of the top 5 videos that
-- have the highest total run time. Report: creator name,
-- video name, and total time played.

SELECT videos.creatorName, videos.videoName, videos.duration
FROM videos
ORDER BY videos.duration DESC LIMIT 5;