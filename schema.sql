-- Personal Finance Tracker - schema.sql
-- Script to create the database schema for a personal finance tracking.

-- drop tables if they exist to start fresh
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Budgets;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Accounts;

-- Table to store different user accounts (checking, savings, credit card)
CREATE TABLE Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    account_name VARCHAR(100) NOT NULL,
    account_type VARCHAR(50) NOT NULL, -- e.g., 'Checking', 'Savings', 'Credit Card'
    balance DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table to store transaction categories
CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    category_type VARCHAR(50) NOT NULL -- 'Expense' or 'Income'
);

-- Table to set monthly budgets for different categories
CREATE TABLE Budgets (
    budget_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    budget_amount DECIMAL(10, 2) NOT NULL,
    budget_month DATE NOT NULL, -- First day of the month, e.g., '2025-08-01'
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    UNIQUE (category_id, budget_month) -- Ensure only one budget per category per month
);

-- Table to log all individual transactions
CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT NOT NULL,
    category_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    transaction_date DATE NOT NULL,
    description VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Add indexes for faster querying on frequently used columns
CREATE INDEX idx_transaction_date ON Transactions(transaction_date);
CREATE INDEX idx_category_id ON Transactions(category_id);
