-- CREATING THE DATABASE
CREATE DATABASE IF NOT EXISTS MYSQLPOC;
USE MYSQLPOC;

-- CREATING THE "AUTHOR" TABLE 
CREATE TABLE AUTHOR(
	ID INT PRIMARY KEY,
    NAME VARCHAR(50)
);

-- CREATING THE "USER" TABLE 
CREATE TABLE USER(
	ID INT PRIMARY KEY,
	NAME VARCHAR(100)
);

-- CREATING THE "POST TABLE 
CREATE TABLE POST(
	ID INT PRIMARY KEY,
	NAME VARCHAR(100),
    AUTHOR_ID INT,
    FOREIGN KEY (AUTHOR_ID) REFERENCES AUTHOR(ID),
    CREATEDTS DATETIME
);

-- CREATING THE "COMMENT" TABLE 
CREATE TABLE COMMENT(
	ID INT PRIMARY KEY,
    CONTENT VARCHAR(1000),
    POST_ID INT,
	FOREIGN KEY (POST_ID) REFERENCES POST(ID),
    CREATEDTS DATETIME,
    USER_ID INT,
	FOREIGN KEY (USER_ID) REFERENCES USER(ID)
);

-- DESCRIBING THE TABLES
DESC AUTHOR;
DESC USER;
DESC POST;
DESC COMMENT;

-- INSERTING VALUES INTO AUTHOR TABLE
INSERT INTO AUTHOR VALUES
(1,"HARISHCHANDRA"),
(2,"JAMES BOND"),
(3,"CHANAKYA");

-- DISPLAYING THE TABLE "AUTOR"
SELECT * FROM AUTHOR;

-- INSERTING VALUES INTO USER TABLE
INSERT INTO USER VALUES
(101,"Vishu"),
(102,"Pratham"),
(103,"Raksha"),
(104,"Manish Gowda"),
(105,"Kavya");

-- DISPLAYING THE TABLE "USER"
SELECT * FROM USER;

-- INSERTING VALUES INTO POST TABLE
INSERT INTO POST VALUES
(1001,"The Devil",1,"2005-01-22"),
(1002,"The Karnataka Soil",3,"2000-05-30"),
(1003,"Ramayan",2,"1995-12-01"),
(1004,"Sunny Day",1,"1999-05-29"),
(1005,"The Fame Artist",3,"2022-01-01"),
(1006,"Music",2,"2018-05-30");

-- DISPLAYING THE TABLE "POST"
SELECT * FROM POST;

-- INSERTING VALUES INTO COMMENT TABLE
INSERT INTO COMMENT VALUES
(11,"Thrilling!!!",1001,"2021-01-01",101),
(12,"Terrific!!!",1001,"2020-05-01",102),
(13,"Nice!!!",1001,"2021-01-06",103),
(14,"Fantastic!!!",1001,"2022-09-01",104),
(15,"Horror!!!",1001,"2021-08-01",105),
(16,"Heaven!!!",1002,"2021-07-01",101),
(17,"Must Watch!!!",1002,"2020-01-03",102),
(18,"Loved It!!!",1002,"2019-04-01",103),
(19,"Super!!!",1002,"2018-11-01",104),
(20,"Good!!!",1002,"2011-12-01",105),
(21,"Visualization is good!!!",1003,"2001-11-29",101),
(22,"Heart Touching!!!",1003,"2005-09-30",102),
(23,"Epic!!!",1003,"2009-08-20",103),
(24,"Glorious!!!",1003,"2019-07-10",104),
(25,"Heart Melting!!!",1003,"2021-06-05",105),
(26,"Dashing!!!",1004,"2021-08-05",101),
(27,"Immense!!!",1004,"1999-04-05",102),
(28,"Sunny!!!",1004,"2007-06-12",103),
(29,"Daring!!!",1004,"2021-06-03",104),
(30,"Loved It!!",1004,"2020-09-05",105),
(31,"Lovely!!!",1005,"2022-01-25",101),
(32,"Glory!!!",1005,"2022-01-28",101),
(33,"Adorable!!!",1005,"2018-07-27",101),
(34,"Clicky!!!",1005,"2020-01-24",101),
(35,"Jolly!!!",1005,"2018-01-23",101),
(36,"Holy!!!",1003,"2022-01-17",105),
(37," Worth Watch!!!",1003,"2021-07-23",104),
(38,"Worthy!!!",1003,"2020-09-25",103),
(39,"Good Job!!!",1003,"2021-11-27",102),
(40,"Great Cinematography!!!",1003,"2018-01-23",101),
(41,"Harmonious!!!",1003,"2017-05-25",105),
(42,"Heaven on Earth!!!",1003,"2016-11-11",101),
(43,"Love for Music!!!","1006","2022-02-01",101),
(44,"Loved the Songs!!!","1006","2022-01-31",105),
(45,"Fabulous!!!","1006","2020-03-29",103);

-- DISPLAYING THE TABLE "COMMENT"
SELECT * FROM COMMENT;

SELECT ID FROM AUTHOR WHERE NAME="JAMES BOND";

-- ==================================================================================================================
-- QUERY TO FETCH LIST OF 10 LATEST COMMENTS OF EACH POST AUTHORED BY "JAMES BOND"
-- JAMES BOND ID IS "2"

WITH  X AS(
	SELECT ID AS POST_ID,NAME AS POST_NAME,AUTHOR_ID FROM POST
        WHERE AUTHOR_ID=(SELECT ID FROM AUTHOR WHERE NAME="JAMES BOND")
), Y AS (
	SELECT POST_ID,ID AS COMMENT_ID,CONTENT,ROW_NUMBER() OVER (PARTITION BY POST_ID ORDER BY ID DESC) AS ROWNUMBER
        FROM COMMENT
)
SELECT  X.POST_ID AS POST_ID,POST_NAME,AUTHOR_ID,COMMENT_ID,CONTENT
FROM X 
LEFT JOIN Y
ON Y.POST_ID=X.POST_ID
WHERE Y.ROWNUMBER<=10;
