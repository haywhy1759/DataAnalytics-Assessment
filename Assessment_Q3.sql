-------------------Assessment_Q3.sql-----------------------
SELECT 
  p.id AS plan_id,
  p.owner_id,
  CASE 
    WHEN p.is_regular_savings = 1 THEN 'Savings' /*--this line of query categorizes the plan as 'Savings' if is_regular_savings is 1-*/
    WHEN p.is_a_fund = 1 THEN 'Investments' /*--this line of query categorizes the plan as 'Investments' if is_a_fund is 1*/
    ELSE 'Other' /*--this line of query categorizes the plan as 'Other' if neither condition is met*/
  END AS type,
  MAX(date(s.transaction_date)) last_transaction_date,
  DATEDIFF(CURDATE(), MAX(s.transaction_date)) AS inactivity_days /*--this line of query calculates the number of days since the last transaction-*/
FROM 
  plans_plan p
LEFT JOIN 
  savings_savingsaccount s ON p.id = s.plan_id
WHERE 
  (p.is_regular_savings = 1 OR p.is_a_fund = 1)
GROUP BY 
  p.id, p.owner_id, p.is_regular_savings, p.is_a_fund, p.created_on
HAVING 
 MAX(s.transaction_date) < CURDATE() - INTERVAL 365 DAY; /*--this line of query filters for plans that have not had any transactions in the last 365 days-*/
