-- Personal Finance Tracker - queries
-- script to run analysis queries on the personal finance data.

-- Query 1: Total Spending by Category for August 2025
-- Shows how much was spent in each category for a given month.
SELECT
    c.category_name,
    SUM(t.amount) AS total_spent
FROM Transactions t
JOIN Categories c ON t.category_id = c.category_id
WHERE c.category_type = 'Expense'
  AND DATE_FORMAT(t.transaction_date, '%Y-%m-01') = '2025-08-01'
GROUP BY c.category_name
ORDER BY total_spent DESC;


-- Query 2: Monthly Spending vs. Budget for August 2025
-- Compares actual spending against the budget for each category.
-- This helps to identify overspending.
WITH monthly_spending AS (
    SELECT
        c.category_id,
        c.category_name,
        SUM(t.amount) AS actual_spent
    FROM Transactions t
    JOIN Categories c ON t.category_id = c.category_id
    WHERE c.category_type = 'Expense'
      AND DATE_FORMAT(t.transaction_date, '%Y-%m-01') = '2025-08-01'
    GROUP BY c.category_id, c.category_name
)
SELECT
    ms.category_name,
    b.budget_amount,
    ms.actual_spent,
    (b.budget_amount - ms.actual_spent) AS difference
FROM monthly_spending ms
JOIN Budgets b ON ms.category_id = b.category_id
WHERE DATE_FORMAT(b.budget_month, '%Y-%m-01') = '2025-08-01'
ORDER BY difference ASC;


-- Query 3: net cash flow per month
-- Calculates total income minus total expenses for each month to show overall financial health.
SELECT
    DATE_FORMAT(transaction_date, '%Y-%m-01') AS month,
    SUM(CASE WHEN c.category_type = 'Income' THEN t.amount ELSE 0 END) AS total_income,
    SUM(CASE WHEN c.category_type = 'Expense' THEN t.amount ELSE 0 END) AS total_expenses,
    SUM(CASE WHEN c.category_type = 'Income' THEN t.amount ELSE -t.amount END) AS net_flow
FROM Transactions t
JOIN Categories c ON t.category_id = c.category_id
GROUP BY month
ORDER BY month;


-- Query 4: running balance for a specific account (Hsbc Checking)
-- Uses a window function to show the balance of an account after each transaction.
SELECT
    t.transaction_date,
    t.description,
    c.category_name,
    CASE
        WHEN c.category_type = 'Income' THEN t.amount
        ELSE -t.amount
    END AS transaction_amount,
    SUM(CASE WHEN c.category_type = 'Income' THEN t.amount ELSE -t.amount END)
        OVER (ORDER BY t.transaction_date, t.transaction_id) AS running_balance
FROM Transactions t
JOIN Categories c ON t.category_id = c.category_id
WHERE t.account_id = (SELECT account_id FROM Accounts WHERE account_name = 'HSBC Checking')
ORDER BY t.transaction_date, t.transaction_id;


-- Query 5: top 5 largest expenses in August 2025
-- Quickly identifies the largest expenses in a given period.
SELECT
    t.transaction_date,
    t.description,
    c.category_name,
    t.amount
FROM Transactions t
JOIN Categories c ON t.category_id = c.category_id
WHERE c.category_type = 'Expense'
AND DATE_FORMAT(t.transaction_date, '%Y-%m-01') = '2025-08-01'
ORDER BY t.amount DESC
LIMIT 5;

-- Query 6: avg daily spending in August 2025
-- Calculates the avg amount spent per day in a specific month.
SELECT
    AVG(daily_total) as average_daily_spending
FROM (
    SELECT
        SUM(amount) as daily_total
    FROM Transactions t
    JOIN Categories c ON t.category_id = c.category_id
    WHERE c.category_type = 'Expense' AND DATE_FORMAT(t.transaction_date, '%Y-%m-01') = '2025-08-01'
    GROUP BY t.transaction_date
) as daily_expenses;
