select
	column_name,
	data_type,
	is_nullable
from information_schema.columns
where table_name ='churn_analysis';

-- How many total customers are there in the churn dataset?

select
	count(*) as total_customers
from churn_analysis;

-- How many customers have churned

select 
	count(*) as total_churn_customers
from churn_analysis
where "Churn" = 'Yes';

-- What is the overall churn rate as a percentage

select 
	count(*) as total_customers,
	count(*) filter (where "Churn" = 'Yes') as churned_customers,
	round((count(*) filter (where "Churn"= 'Yes') / count(*)::numeric)*100,2) as churn_rate
from churn_analysis;

-- What is the average monthly charges across all customers

select 
	round(avg("MonthlyCharges")::numeric,2)as monthly_charges
from churn_analysis;

-- What is the average tenure of all customers, in months?

select 
	round(avg(tenure),2) as avg_tenure
from churn_analysis;

-- How many customers are there in each contract type?

select
	"Contract",
	count(*) as total_customers
from churn_analysis
group by "Contract";

-- What is the churn rate for each contract type

select
	"Contract",
	round(count(*) filter (where "Churn" = 'Yes')::numeric/ count(*)*100,2) as churn_rate
from churn_analysis
group by "Contract";

-- How many customers churned under each contract type

select
	"Contract",
	count(*) as churned_customers
from churn_analysis
where "Churn" = 'Yes'
group by "Contract";

-- What is the average monthly charge for each contract type

select
	"Contract",
	round(avg("MonthlyCharges")::numeric,2) as avg_monthly
from churn_analysis
group by "Contract";

-- what is the average tenure of churned customers compared to non_churned customers
select
	"Churn",
	round(avg(tenure)::numeric,2) as avg_tenure
from churn_analysis
group by "Churn";

-- How many customers have a tenure of 12 months or less?

select
	count(*) as total_customers
from churn_analysis
where tenure <=12;

-- What is the churn rate among customers with tenure of 12 months or less?

select 
	round(count(*) filter (where "Churn"= 'Yes')::numeric/ count(*) * 100 ,2)as churned_rate
from churn_analysis
where tenure <= 12;

-- Which tenure group has the highest number of churned customers
With churn_group as (
	select
		"customerID",
		"Churn",
		case
			when tenure <=12 then '0-12'
			when tenure <=24 then '13-24'
			when tenure <=48 then '25-48'
			else '49+'
		end as tenure_months_category
	from churn_analysis
)
select
tenure_months_category,
count(*) filter (where "Churn" = 'Yes') as churned_customers
from churn_group
group by tenure_months_category
order by churned_customers desc
limit 1;

-- What is the average monthly charge for churned customers compared with non-chuned customers?

select
	"Churn",
	round(avg("MonthlyCharges")::numeric,2) as avg_monthly_charges
from churn_analysis
group by "Churn";

-- What is the total monthly revenue from customers who have CHurn and not churned?

select
	"Churn",
	round(sum("MonthlyCharges")::numeric,2) as monthly_revenue
from churn_analysis
group by "Churn";

-- Which contract type generates the highest total monthly revenue?

select 
	"Contract",
	sum("MonthlyCharges") as monthly_revenue
from churn_analysis
group by "Contract"
order by monthly_revenue desc
limit 1;

-- What is the churn rate by Internet Service

select
	"InternetService",
	round(count(*) filter (where "Churn" = 'Yes')::numeric/ count(*) * 100,2) as churn_rate
from churn_analysis
group by "InternetService";

-- what is the churn rate of each combination of InternetService and Contract Type ?

select
	"Contract",
	"InternetService",
	round(count(*) filter (where "Churn" = 'Yes')::numeric/ count(*) * 100,2) as churn_rate
from churn_analysis
group by "Contract","InternetService"
order by "Contract";

-- How many customers have Online Security and how does their churn rate compare with customers without oneline security

select
	"OnlineSecurity",
	count(*) as total_customers,
	round(count(*) filter (where "Churn" = 'Yes')::numeric/ count(*)*100,2) as churn_rate
from churn_analysis
group by "OnlineSecurity";

-- How does churn rate compare between customers with and without Tech Support?

select
	"TechSupport",
	count(*) as total_customers,
	round(count(*) filter (where "Churn" = 'Yes')::numeric/ count(*)*100,2) as churn_rate
from churn_analysis
group by "TechSupport";

-- How many customers have both low tenure (12 month or less) and high monthly charges (over $70)

select
	count(*) as total_customers
from churn_analysis
where tenure <= 12 and "MonthlyCharges" > 70;

-- How many customers have both high monthly charges (over $70) and a Month-to-month contract ?

select
	count(*) as total_customers
from churn_analysis
where "MonthlyCharges" > 70 
and "Contract" = 'Month-to-month';
	
-- What percentage of churned customers were on Month-to-month contracts ?

select
	count(*) Filter (where "Churn" = 'Yes' and "Contract" = 'Month-to-month')::numeric/
	count(*) Filter (where "Churn" = 'Yes') * 100 as percentage
from churn_analysis;

-- Which contract type has the highest number of churned customers ?

select
	"Contract",
	count(*) Filter (where "Churn" = 'Yes') as churned_customers
from churn_analysis
group by "Contract"
order by churned_customers desc
limit 1;

-- What is the average TotalCharges for churned vs non-churned customers?

select 
	"Churn",
	round(avg("TotalCharges")::numeric,2) as avg_total_charges
from churn_analysis
group by "Churn";

-- Which contract types have more than 1000 customers ?

Select 
	"Contract",
	count(*) as total_customers
from churn_analysis
group by "Contract"
having count(*) > 1000;


-- Which Internet Service types have a churn rate above 30 % ?
With internet_churn as (
	select 
		"InternetService",
		round(count(*) Filter (where "Churn" = 'Yes')::numeric / count(*) * 100,2) as churn_rate
	from churn_analysis
	group by "InternetService"
)
select *
from internet_churn
where churn_rate > 30;


-- Which contract have an average monthly charge greater than 65 ?

select 
	"Contract",
	avg("MonthlyCharges") as avg_monthly_charges
from churn_analysis
group by "Contract"
having avg("MonthlyCharges") > 65;

-- For each contract type, calculate its churn rate, then return only contract types where churn rate is above 10% ?

With contract_churn as (
	select 
		"Contract",
		round(count(*) filter (where "Churn" = 'Yes')::numeric/ count(*) * 100,2) as churn_rate
	from churn_analysis
	group by "Contract"
)
select *
from contract_churn
where churn_rate > 10;

-- Rank the contract types from highest to lowest churn rate using a window functions
With contract_churn as (
	select 
		"Contract",
		round(count(*) filter (where "Churn" = 'Yes')::numeric/ count(*) * 100,2) as churn_rate
	from churn_analysis
	group by "Contract"
)
select  *,
	rank() over (order by churn_rate desc) as contract_rank
from contract_churn;

-- For each conract type, show its average monthly charges and the differences from the overall average monthly charges
With contract_avg as (
	select 
		"Contract",
		round(avg("MonthlyCharges")::numeric,2) as avg_monthly,
		round(avg(avg("MonthlyCharges")) over ()::numeric,2) as overall_monthly
	from churn_analysis
	group by "Contract"
)
select *,
	(avg_monthly -overall_monthly) as differences
from contract_avg;

-- Find the customers whose monthly charge is higher than the overall average monthly charges ?

select *
from churn_analysis
where "MonthlyCharges" > (
	select avg("MonthlyCharges") from churn_analysis
);

-- For each contract show total_customers, churned_customers, churn_rate and rank the contract types by churn rate?

With contract_details as (
	select
		"Contract",
		count(*) as total_customers,
		count(*) Filter (where "Churn" = 'Yes') as churned_customers,
		round(count(*) Filter (where "Churn" = 'Yes')::numeric/ count(*) * 100,2) as churn_rate
	from churn_analysis
	group by "Contract"
)
select *,
	rank() over (order by churn_rate desc) as rank_contract
from contract_details;

-- Classify customers into monthly charges < 40 (Low), 40-70 as Medium, > 70 as High , then show no of customers and churn rate for each category
With customer_details as (
	select
		"customerID",
		"Churn",
		case
			when "MonthlyCharges" < 40 then 'Low'
			when "MonthlyCharges" between 40 and 70 then 'Medium'
			Else 'High'
		end as monthly_charges_category
	from churn_analysis
)
select 
	monthly_charges_category,
	count(*) as total_customers,
	round(count(*) Filter (where "Churn" = 'Yes')::numeric / count(*) * 100,2) as churn_rate
from customer_details
group by monthly_charges_category;
	

	



















