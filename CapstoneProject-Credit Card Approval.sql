-- created database
create database Finalproject;
use finalproject;


-- retrieve the entire dataset
select * from credit_approval;

-- check if any null values in your dataset, The primary use of COALESCE is to handle null values effectively and provide a fallback 

SELECT *
FROM credit_approval
WHERE COALESCE('Ind_id', 'Gender', 'Car_Owner', 'Propert_Owner', 'Children',
       'Annual_income', 'Type_Income', 'Education', 'Marital_status',
       'Housing_type', 'Age', 'Employed_exp', 'Mobile_phone', 'Work_Phone',
       'Phone', 'Email_id', 'Type_Occupation', 'Family_Members', 'label') IS NULL; -- So, there is no null values in Dataset
       
/* ________________________________________________________________________________________________________________________________
____________________________________________________________________________________________________________________________________ */

-- 1) Group the customers based on their income type and find the average of their annual income.

select * from credit_approval;

SELECT
  Type_Income,
  AVG(Annual_income) AS average_annual_income
FROM
  (
    SELECT
      Type_Income,
      Annual_income
    FROM
      credit_approval
  ) B
GROUP BY
  Type_Income; 
/* _____________________________________________________________________________________________________________*/
-- 2) Find the female owners of cars and property.
SELECT 
    C.Gender ,
    C.Car_Owner AS carowner,
    COUNT(*) AS count_female_car_owners,
    P.Propert_Owner AS propertyowner,
    COUNT(*) AS count_female_property_owners
FROM 
    credit_approval C
    JOIN credit_approval P ON C.Ind_ID = P.Ind_ID
WHERE 
    C.Gender = 'F' AND C.Car_Owner IN ('Y', 'N') AND P.Gender = 'F' AND P.Propert_Owner IN ('Y', 'N')
GROUP BY 
    C.Gender, C.Car_Owner,  P.Propert_Owner;
/*______________________________________________________________________________________________________________________*/
-- 3) Find the male customers who are staying with their families.

SELECT Gender,Housing_type, count(*) staying_with_families
FROM credit_approval
WHERE Gender = 'M' AND Housing_type = 'House / apartment'
                          group by 1,2;
/*______________________________________________________________________________________________________________________*/ 
-- 4) Please list the top five people having the highest income.
select * from credit_approval;

select * from credit_approval 
                where Annual_income 
	order by Annual_income desc limit 5;
    
/* __________________________________________________________________________________________________________________________*/
-- 5) How many married people are having bad credit?
-- Label: 0 is application approved (good credit) and 1 (bad credit) is application rejected. 
SELECT Marital_status,label, COUNT(*) as count_bad_credit
FROM credit_approval
WHERE Marital_status = 'Married' AND label = 1;  -- Married people had been rejected there application with bad credit score 1.

-- good credit application approved Married
SELECT Marital_status,label, COUNT(*) as count_bad_credit
FROM credit_approval
WHERE Marital_status = 'Married' AND label = 0; -- Married people had been approved there application with good credit score 0.

/* _________________________________________________________________________________________________________________________________*/

-- 6) What is the highest education level and what is the total count?

select EDUCATION ,COUNT(*) AS TOTAL_NUMS
                           FROM credit_approval 
			WHERE EDUCATION='Higher education' group by 1; -- there are 421 students completed there higher education 

/* ___________________________________________________________________________________________________________________________*/

-- Between married males and females, who is having more bad credit? 

SELECT Marital_status, Gender, COUNT(*) AS count_bad_credit
FROM credit_approval
WHERE Marital_status = 'Married' AND label = 1
GROUP BY Marital_status, Gender;


