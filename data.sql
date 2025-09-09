-- Personal Finance Tracker - data.sql
-- This script populates the tables with sample data for the year 2025.

-- Insert Accounts 
INSERT INTO Accounts (account_name, account_type, balance) VALUES
('HSBC Checking', 'Checking', 5250.75),
('Barclays Savings', 'Savings', 12300.00),
('Amex', 'Credit Card', -450.25);

-- Insert Categories 
INSERT INTO Categories (category_name, category_type) VALUES
('Salary', 'Income'),
('Freelance Work', 'Income'),
('Groceries', 'Expense'),
('Transport', 'Expense'),
('Eating Out', 'Expense'),
('Utilities', 'Expense'),
('Rent', 'Expense'),
('Shopping', 'Expense'),
('Entertainment', 'Expense');

-- Insert Budgets for August 2025
INSERT INTO Budgets (category_id, budget_amount, budget_month) VALUES
((SELECT category_id FROM Categories WHERE category_name = 'Groceries'), 400.00, '2025-08-01'),
((SELECT category_id FROM Categories WHERE category_name = 'Transport'), 150.00, '2025-08-01'),
((SELECT category_id FROM Categories WHERE category_name = 'Eating Out'), 250.00, '2025-08-01'),
((SELECT category_id FROM Categories WHERE category_name = 'Utilities'), 200.00, '2025-08-01'),
((SELECT category_id FROM Categories WHERE category_name = 'Rent'), 1200.00, '2025-08-01'),
((SELECT category_id FROM Categories WHERE category_name = 'Shopping'), 300.00, '2025-08-01');

-- Insert Budgets for September 2025
INSERT INTO Budgets (category_id, budget_amount, budget_month) VALUES
((SELECT category_id FROM Categories WHERE category_name = 'Groceries'), 400.00, '2025-09-01'),
((SELECT category_id FROM Categories WHERE category_name = 'Transport'), 150.00, '2025-09-01'),
((SELECT category_id FROM Categories WHERE category_name = 'Eating Out'), 200.00, '2025-09-01');


-- Insert Transactions for August 2025
INSERT INTO Transactions (account_id, category_id, amount, transaction_date, description) VALUES
(1, 1, 3500.00, '2025-08-05', 'Monthly Salary'),
(1, 7, 1200.00, '2025-08-01', 'Monthly Rent Payment'),
(1, 6, 85.50, '2025-08-10', 'Electricity Bill'),
(3, 3, 75.20, '2025-08-03', 'Tesco Weekly Shop'),
(3, 3, 92.80, '2025-08-10', 'Sainsburys Groceries'),
(3, 3, 65.10, '2025-08-18', 'Lidl Shopping'),
(3, 3, 81.45, '2025-08-25', 'Waitrose Groceries'),
(3, 4, 24.50, '2025-08-12', 'TfL Fare'),
(3, 4, 33.00, '2025-08-18', 'Uber ride'),
(3, 5, 45.00, '2025-08-09', 'Dinner with friends at Nandos'),
(3, 5, 28.50, '2025-08-15', 'Lunch at Pret A Manger'),
(3, 8, 129.99, '2025-08-16', 'New shoes from sports direct'),
(3, 9, 45.00, '2025-08-29', 'Cinema tickets - Cineworld'),
(2, 2, 550.00, '2025-08-20', 'Web Design Project');

-- Insert Transactions for September 2025 (up to current date)
INSERT INTO Transactions (account_id, category_id, amount, transaction_date, description) VALUES
(1, 1, 3500.00, '2025-09-01', 'Monthly Salary'),
(1, 7, 1200.00, '2025-09-01', 'Monthly Rent Payment'),
(3, 3, 68.90, '2025-09-01', 'Tesco Groceries');
