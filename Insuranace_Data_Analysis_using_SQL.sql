create database insurance_project;
use insurance_project;

-- Reading the data set 
SELECT * from insurance_data;

-- Displaying the average claim amount for all patients in each region 
SELECT region, avg(claim) as Avg_Claim from insurance_data
group by region;

-- Selecting  max and min BMI values 
SELECT min(bmi) as min_bmi , max(bmi) as max_bmi from insurance_data;


-- Selecting the PatientID, age, and BMI for patients with a BMI between 40 and 50
SELECT PatientID, age , BMI from insurance_data
WHERE BMI between 40 and 50;


-- Selectin the number of smokers in each region 
SELECT count(smoker) as number_of_smokers , region from insurance_data
where smoker = 'Yes'
group by region;


-- Finding the average calim amount for patients who are both diabetic and smokers 
SELECT avg(claim) as avg_claim_amount from insurance_data
WHERE diabetic= 'Yes' and smoker = 'Yes';

-- Finding all the patients who have  bmi GREATER THAN AVERAGE bmi OF PATIENTS WHO ARE SMOKERS 
SELECT * from insurance_data
where bmi > (select avg(bmi) from insurance_data where smoker='Yes');
-- select avg(bmi) where smoker='Yes'

-- Finding the average claim amount for patients in each age group 
SELECT 

      case when age <18 then 'under 18'
      when age between 18 and 30 then '18-30'
      when age between 30 and 50 then '31-50'
      else 'Over-50'
end as age_group , avg(claim) as claim_amount
from insurance_data
group by age_group;


-- Finding the total claim amount for each patient and along with the average calim amount across all patients 
SELECT *, sum(claim) over(partition by PatientID) as toatl_claim , avg(claim) over() as avg_claim from insurance_data;


-- Finding the top 3 patients with the highest calim amount , along with their respective calim amounts and the total calim amount for all patients
SELECT PatientID, claim , sum(claim) over() as total_claim from insurance_data
order by claim desc
limit 3;


-- Finding the details of patients who have a claim amount greater than average claim amount for their  region 
SELECT *  from ( select *, avg(claim) over(partition by region) as avg_claim from insurance_data) as subquery 
where claim >  avg_claim;


-- Finding the rank of each patient based on their claim amount 
SELECT *, rank() over(order by claim desc) from insurance_data;


-- Selecting the detils of patients along with their claim amount, and their rank based on claim amount within their region 
SELECT *, rank() over(partition by region order by claim desc) from insurance_data;
-- SELECT avg(claim) from insurance_data 


-- 









