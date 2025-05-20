SELECT 
  a.id AS customer_id,
  a.name,
  TIMESTAMPDIFF(MONTH, a.created_on, CURDATE()) AS tenure_months, /*--this line of query calculates the number of months since the user was created-*/
  COUNT(*) AS total_transactions,
  ROUND(
    (COUNT(*) / NULLIF(TIMESTAMPDIFF(MONTH, a.created_on, CURDATE()), 0)) /*--this line of query calculates the average number of transactions per month-*/
    * 12 
    * (0.1 * AVG(b.amount/100)), 
    2
  ) AS estimated_clv /*--this line of query estimates the customer lifetime value (CLV) based on the average transaction amount and frequency-*/
FROM 
  users_customuser a
JOIN 
  savings_savingsaccount b ON a.id = b.owner_id
WHERE 
  b.transaction_status IN ('successful', 'success') /*--this line of query filters for successful transactions-*/
GROUP BY 
  a.id, a.name
ORDER BY 
  estimated_clv DESC;
