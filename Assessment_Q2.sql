/*This CTE breaks down each user's transactions by month*/
WITH user_monthly_txns AS (    
  SELECT 
    owner_id,
    DATE_FORMAT(transaction_date, '%Y-%m') AS txn_month, /*--this line of query breaks down the transaction date into months-----*/
    COUNT(*) AS monthly_txn_count
  FROM savings_savingsaccount
  GROUP BY owner_id, txn_month
), 
/*This CTE calculates the average number of transactions per month for each user. */ 
user_avg_txns AS (
  SELECT 
    owner_id,
    AVG(monthly_txn_count) AS avg_txn_per_month /*--this line of query calculates the average number of transactions per month-----*/
  FROM user_monthly_txns
  GROUP BY owner_id
), 
/*This CTE categorizes users based on their average transactions per month. */
  user_categories AS (
  SELECT
    u.id AS owner_id,
    CASE 
      WHEN avg_txn_per_month >= 10 THEN 'High Frequency' /*--this line of query categorizes users with 10 or more transactions per month as 'High Frequency'*/
      WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency' /*--this line of query categorizes users with 3 to 9 transactions per month as 'Medium Frequency'--*/
      ELSE 'Low Frequency' /*--this line of query categorizes users with less than 3 transactions per month as 'Low Frequency'-*/
    END AS frequency_category,
    COALESCE(a.avg_txn_per_month, 0) AS avg_txn_per_month
  FROM users_customuser u
  LEFT JOIN user_avg_txns a ON u.id = a.owner_id
)
/*This final query aggregates the data to show the number of customers in each frequency category and their average transactions per month. */
SELECT
  frequency_category,
  COUNT(DISTINCT owner_id) AS customer_count,
  ROUND(AVG(avg_txn_per_month), 2) AS avg_transactions_per_month /*--this line of query calculates the average number of transactions per month for each frequency category-*/
FROM user_categories
GROUP BY frequency_category
ORDER BY
  CASE frequency_category
    WHEN 'High Frequency' THEN 1 /*--this line of query orders the frequency categories with 'High Frequency' first-*/
    WHEN 'Medium Frequency' THEN 2 /*--this line of query orders the frequency categories with 'Medium Frequency' second-*/
    WHEN 'Low Frequency' THEN 3 /*--this line of query orders the frequency categories with 'Low Frequency' last-*/
  END;
