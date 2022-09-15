/* 

HackerRank Advanced Select Challenges & My Solutions

Skills used: SQL, Using MySQL & Miscrosoft SQL

*/

/*
Type of Triangle
Write a query identifying the type of each record in the TRIANGLES table using its three side lengths. Output one of the following statements for each record in the table:
Equilateral: It's a triangle with  sides of equal length.
Isosceles: It's a triangle with  sides of equal length.
Scalene: It's a triangle with  sides of differing lengths.
Not A Triangle: The given values of A, B, and C don't form a triangle
*/
SELECT 
    CASE
        WHEN (a + b <= c) OR (b + c <= a) OR (a + c <= b) THEN 'Not A Triangle'
        WHEN (a = b) AND (b = c) THEN 'Equilateral'
        WHEN (a = b) OR (b = c) OR (c = a) THEN 'Isosceles'
        WHEN (a <> b) AND (b <> c) AND (c <> a) THEN 'Scalene' 
    END tuple
FROM TRIANGLES;

/*
Type of Triangle
Generate the following two result sets:
Query an alphabetically ordered list of all names in OCCUPATIONS, immediately followed by the first letter of each profession as a parenthetical (i.e.: enclosed in parentheses). For example: AnActorName(A), ADoctorName(D), AProfessorName(P), and ASingerName(S).
Query the number of ocurrences of each occupation in OCCUPATIONS. Sort the occurrences in ascending order, and output them in the following format: 
There are a total of [occupation_count] [occupation]s.
where [occupation_count] is the number of occurrences of an occupation in OCCUPATIONS and [occupation] is the lowercase occupation name. If more than one Occupation has the same [occupation_count], they should be ordered alphabetically.
*/
SELECT CONCAT(name, '(', LEFT(occupation,1), ')') 
FROM OCCUPATIONS ORDER BY name ASC;

-- s. is used to denote string
SELECT 'There are a total of', (COUNT(occupation)), CONCAT(LOWER(occupation), 's.') 
FROM OCCUPATIONS GROUP BY occupation ORDER BY count(occupation) ASC, occupation ASC;
-- OR (There are 2 solutions for 2nd part of the question)
SELECT CONCAT('There are a total of ', COUNT(occupation), ' ', LOWER(occupation), 's.') 
FROM OCCUPATIONS GROUP BY occupation ORDER BY count(occupation) ASC, occupation ASC;

/*
Occupations
Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically and displayed underneath its corresponding Occupation. The output column headers should be Doctor, Professor, Singer, and Actor, respectively.
Note: Print NULL when there are no more names corresponding to an occupation.
Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.
The first column is an alphabetically ordered list of Doctor names. 
The second column is an alphabetically ordered list of Professor names. 
The third column is an alphabetically ordered list of Singer names. 
The fourth column is an alphabetically ordered list of Actor names. 
The empty cell data for columns with less than the maximum number of names per occupation (in this case, the Professor and Actor columns) are filled with NULL values.
*/
SELECT
    [Doctor],
    [Professor],
    [Singer],
    [Actor]
FROM 
    (SELECT 
-- Row_number is the Num.1,2,3, giving a number to each row
-- Over is just a clause to combine both
-- Partition_by is partitioning the query
        ROW_NUMBER() OVER (PARTITION BY occupation ORDER BY name) rn,
        [name],
        [occupation]
     FROM
        OCCUPATIONS
     ) AS source
PIVOT
-- Only pull out Max to avoid NULL values
    (MAX(name) FOR [occupation] IN ([Doctor], [Professor], [Singer], [Actor])) as pvt
ORDER by rn

/*
Binary Tree Nodes
You are given a table, BST, containing two columns: N and P, where N represents the value of a node in Binary Tree, and P is the parent of N.
Write a query to find the node type of Binary Tree ordered by the value of the node. Output one of the following for each node:
Root: If node is root node.
Leaf: If node is leaf node.
Inner: If node is neither root nor leaf node.
*/

SELECT b.N,
    -- b is a subsquery
    -- Use Case when there are conditions to go through, close with End
    (CASE 
        -- when there is no parent
        WHEN b.P IS NULL THEN 'Root' 
        -- at least one node has this node as parent
        -- the select 1 is the 1st column
        WHEN EXISTS (SELECT 1 FROM BST b2 WHERE b2.P = b.N) THEN 'Inner'
        -- not a parent and no nodes have this have this as a parent
        ELSE 'Leaf'
     END)
FROM BST b
ORDER BY N;

/* TO BE CONTINUE */
