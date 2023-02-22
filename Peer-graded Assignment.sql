--Exercise 1, Question 1: 

--Write and execute a SQL query to list the school names, community names 
--and average attendance for communities with a hardship index of 98. 

SELECT NAME_OF_SCHOOL,cd.COMMUNITY_AREA_NAME,AVERAGE_STUDENT_ATTENDANCE 
FROM CENSUS_DATA cd
INNER JOIN CHICAGO_PUBLIC_SCHOOLS cps
ON cd.community_area_number = cps.community_area_number
WHERE hardship_index = 98

--Exercise 1 - Question 2

--Write and execute a SQL query to list all crimes that 
-- took place at a school. Include case number, crime type and community name.

SELECT CASE_NUMBER, PRIMARY_TYPE, cd.COMMUNITY_AREA_NAME
FROM CHICAGO_CRIME_DATA ccd
LEFT JOIN CENSUS_DATA cd
ON  ccd.COMMUNITY_AREA_NUMBER = cd.COMMUNITY_AREA_NUMBER
WHERE ccd.LOCATION_DESCRIPTION LIKE '%SCHOOL%'

--Exercise 2, Question 1: 

--Write and execute a SQL statement that returns just the 
--school name and leaders’ icon from the view. 

SELECT NAME_OF_SCHOOL, LEADERS_ICON
FROM CHICAGO_PUBLIC_SCHOOLS

--Exercise 3, Question 1: 

--Write the structure of a query to create or replace a stored procedure 
--called UPDATE_LEADERS_SCORE that takes a in_School_ID parameter as an integer 
--and a in_Leader_Score parameter as an integer. Don't forget to use the 
--#SET TERMINATOR statement to use the @ for the CREATE statement terminator. 

--#SET TERMINATOR @
CREATE OR REPLACE PROCEDURE UPDATE_LEADERS_SCORE ( 
    IN in_School_ID INTEGER, IN in_LEADER_Score INTEGER ) -- ( { IN/OUT type } { parameter-name } { data-type }, ... )

LANGUAGE SQL                                                -- Language used in this routine
MODIFIES SQL DATA    
BEGIN                                       
END
@