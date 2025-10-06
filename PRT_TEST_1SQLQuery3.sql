CREATE DATABASE PRT_Test;

USE PRT_Test;

SELECT * FROM dbo.Student_Cheating_dataset

-----------START--------------
--1) Cheating Analysis:
-- Count how many students cheated and how many did not.
SELECT 
SUM(CASE WHEN cheated = 1 THEN 1 ELSE 0 END) AS Cheated_Students,
SUM(CASE WHEN cheated = 0 THEN 1 ELSE 0 END) AS Not_Cheated_Students
FROM dbo.Student_Cheating_dataset;

----------------------------------------------------------------------
--2) Penalty Distribution:
-- Retrieve the average, minimum, and maximum penalty points given to students.
SELECT AVG(Penalty_Points) As Copied_Stu_AVG_Penalty_points,
	   MIN(Penalty_Points) AS Copied_Stu_MIN_Penalty_points,
	   MAX(Penalty_Points) AS Copied_Stu_MAX_Penalty_points
FROM dbo.Student_Cheating_dataset;

-----------------------------------------------------------------------
--3) Behavior and Cheating:
-- Find the most common behavior among students who were caught cheating.
SELECT TOP 1 
    student_behavior,
    COUNT(*) AS Behavior_Count
FROM dbo.Student_Cheating_dataset
WHERE caught_cheating = 1
GROUP BY student_behavior
ORDER BY COUNT(*) DESC;

------------------------------------------------------------------------------
---4) Proctor Impact:
--- Count how many students cheated in exams with a proctor present vs. without a proctor.
SELECT 
    proctor_present,
    COUNT(*) AS Cheated_Students ----Using COUNT
FROM dbo.Student_Cheating_dataset
WHERE cheated = 1
GROUP BY proctor_present;

----------------------------------------------------------------------------------
--5) Subject-Wise Cheating Rates:
-- Calculate the percentage of students who cheated in each subject.
SELECT  ----Using COUNT
    subject,
    COUNT(CASE WHEN cheated = 1 THEN 1 END) * 100.0 / COUNT(*) AS Cheating_Percentage
FROM dbo.Student_Cheating_dataset
GROUP BY subject;
        ------CTE 
WITH SubjectStats AS (
    SELECT 
        subject,
        COUNT(*) AS Total_Students,
        SUM(CASE WHEN cheated = 1 THEN 1 ELSE 0 END) AS Cheated_Students
    FROM dbo.Student_Cheating_dataset
    GROUP BY subject
) 
SELECT
    subject,
    (Cheated_Students * 100.0 / Total_Students) AS Cheating_Percentage
FROM SubjectStats;

------------------------END-------------------------------------------------