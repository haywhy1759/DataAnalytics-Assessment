----------------Assessment_Q1.sql------------------
SELECT 
  a.owner_id, 
  b.name, 
  COUNT(DISTINCT CASE WHEN a.is_regular_savings = 1 THEN a.id END) AS savings_count, /*--this line of query counts users with savings accounts-----*/
  COUNT(DISTINCT CASE WHEN a.is_a_fund = 1 THEN a.id END) AS investment_count,  /*-this line of query counts users with investment accounts-----*/
  SUM(c.amount) AS total_deposits
FROM 
  `plans_plan` a
JOIN 
  `users_customuser` b ON a.owner_id = b.id  /*-this line of query joins `plans_plan` table with `users_customuser` tabel using owner_id & id columns in each table -----*/
JOIN 
  `savings_savingsaccount` c ON a.id = c.plan_id /*-this line of query joins `plans_plan` table with `savings_savingsaccount` tabel using id & plan_id columns in each table -----*/
WHERE 
  c.transaction_status IN ('successful', 'success') /*-this line of query filters for successful transactions-*/
GROUP BY 
  a.owner_id, b.first_name, b.last_name
HAVING 
  savings_count > 0 
  AND investment_count > 0 /*-this line of query filters for users that have done at least 1 savings and investment transaction-----*/
ORDER BY total_deposits DESC; 


