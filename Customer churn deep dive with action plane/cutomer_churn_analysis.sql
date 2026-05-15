--Understanding our dataset

-- Q1 What are the total no. of customer?
select count(*) from analysis;


--Q2 What is the total number of customers who churned?
select count(*) as churn_count from analysis where "Churn"='Yes';


--Q3 Out of the total customers what is the overall churn rate?
select round(count(case when "Churn" = 'Yes' then 1 end)*100.0/count(*),2)
as churn_rate from analysis;


--Q4 How many customers churned gender wise?
select count(*) as churn_count,"gender" from analysis where "Churn"='Yes' group by "gender"
order by churn_count desc;


--Q5 How many customers churned on the basis of different contracts?
select count(*) as churn_count,"Contract" from analysis where "Churn" = 'Yes' group by "Contract"
order by churn_count desc;


--Q6 How many customers churned payment method wise?
select count(*) as churn_count,"PaymentMethod" from analysis where "Churn"='Yes' group by "PaymentMethod"
order by churn_count desc;


--Q7 What are the average monthly charges of customers who churned?
select round(avg("MonthlyCharges"::numeric),2) as avg_monthly_charges from analysis where "Churn"='Yes';


--Business related insights

--Q8 What is the churn rate based on Contract type?
select "Contract",round(count(case when "Churn" = 'Yes' then 1 end)*100.0/count(*),2)
as churn_rate from analysis group by "Contract" order by churn_rate desc;


--Q9 What is the total revenue loss faced due to churn?
select round(sum("MonthlyCharges")::numeric,2) as revenue_loss from analysis where "Churn"='Yes';


--Q10 What id the average tenure before churn?
select round(avg("tenure"::numeric),2) as avg_tenure from analysis where "Churn"='Yes';


--Q11 Which internet service is causing highest churn?
select "InternetService", count(*) as churn_count from analysis where "Churn" ='Yes'
group by "InternetService" order by churn_count desc;


--Q12 Who are the top-10 high value customers who churned?
select "customerID","MonthlyCharges","TotalCharges" from analysis where "Churn" = 'Yes' 
order by "TotalCharges" desc limit 10;


--Q13 What is senior citizen churn rate?
select "SeniorCitizen",round(count(case when "Churn" = 'Yes' then 1 end)*100.0/count(*),2)
as churn_rate from analysis group by "SeniorCitizen";


--Q14 Which combination has highest churn rate?
select "Contract","InternetService",count(*) as churn_count from analysis where "Churn" ='Yes'
group by "Contract","InternetService"
order by churn_count desc;

--Actionable insights

--Q15 Based on tenure, monthly charges, contract categorise customers into differnet categories.
select "customerID","tenure","MonthlyCharges","Contract" ,
case 
when "tenure"<12 and
"MonthlyCharges">70 and
"Contract" = 'Month-to-month' then 'High Risk'
when "tenure"<24 then 'Medium Risk'
else 'Low Risk'
end as risk_category from analysis;


--Q16 Identify customers who are likely to stay long_term
select "customerID", "Contract", "TotalCharges" from analysis where "tenure">60 order by "TotalCharges" desc;


--Q17 Are there any customer who arehigh paying but still leaving early?
select "customerID","tenure","MonthlyCharges" from analysis where "tenure"<12 and "MonthlyCharges">80 and 
"Churn" = 'Yes';


--Q18 Identify which customers can be retained, so that the companies pays more attention to them?
select "customerID","Contract","MonthlyCharges","tenure" from analysis where "Churn" = 'Yes' and 
"Contract"='Month-to-month' and "tenure"<12;





















