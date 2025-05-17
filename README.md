# DataAnalytics-Assessment

## Overview
This repository contains SQL solutions for a Data Analyst Assessment focused on analyzing customer savings and investment behaviors. The database includes tables such as `users_customuser`, `savings_savingsaccount`, `plans_plan`, and `withdrawals_withdrawal`. The assessment covers SQL topics including joins, aggregations, conditional logic, and time-based calculations.

---

## Repository Structure

```
DataAnalytics-Assessment/
├── Assessment_Q1.sql
├── Assessment_Q2.sql
├── Assessment_Q3.sql
├── Assessment_Q4.sql
└── README.md
```

---

## Per-Question Explanations

### Assessment_Q1.sql
**Objective:** Calculate total savings per user and count of funded savings and investment plans.

**Approach:**
- Joined `plans_plan`, `savings_savingsaccount`, and `users_customuser`.
- Used `CASE` expressions to conditionally count savings vs investment plans.
- Grouped by user to return aggregated totals.

---

### Assessment_Q2.sql
**Objective:** Identify users with both funded savings and investment plans.

**Approach:**
- Used `CASE` inside `COUNT(DISTINCT a.id)` to segregate savings and investment types.
- Applied `HAVING` to filter users with `savings_count > 0` and `investment_count > 0`.

---

### Assessment_Q3.sql
**Objective:** Categorize customers based on average monthly transaction frequency.

**Approach:**
- Used CTEs to:
  1. Count transactions per user per month.
  2. Calculate average transactions per user.
  3. Categorize users into frequency segments (High, Medium, Low).
- Joined with `users_customuser` to ensure all users were included.

---

### Assessment_Q4.sql
**Objective:** Estimate CLV (Customer Lifetime Value) using tenure and transaction volume.

**Approach:**
- Calculated account tenure using `TIMESTAMPDIFF(MONTH, created_on, CURRENT_DATE)`.
- Counted successful transactions per user.
- Used simplified CLV formula:  
  `(total_transactions / tenure) * 12 * avg_profit_per_transaction`, with 0.1% profit assumption.

---

## Challenges & Resolutions

- **Large Dataset Insertion:** Faced performance issues when inserting data in DBeaver. Resolved by switching to Visual Studio Code for smoother execution.
- **Duplicate Entry Errors:** Encountered a `Duplicate entry` error due to primary key conflicts; resolved by inspecting the data and removing duplicates.
- **VS Code Git Commit Issues:** Experienced difficulties initializing and linking the repository in VS Code without using the terminal. Eventually resolved by cloning the repo first and saving files directly into the cloned folder.
- **Proper Case Formatting:** Transformed user name fields into Proper Case using SQL string functions for consistent formatting.
- **Null 'name' Column:** Had to concatinate the first_name and last_name to get a proper name that fits the expected result.



---

## Technologies Used
- **Database:** MySQL
- **Editor:** Visual Studio Code
- **Version Control:** GitHub

---

## Notes
- All queries were tested for correctness, readability, and efficiency.
- Comments were added throughout the SQL files to explain key logic.
- This repository contains only SQL files and this README, as required.