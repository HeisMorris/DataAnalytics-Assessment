# Data Analytics Assessment - SQL Solutions

## Repository Overview
This repository contains SQL solutions for a data analytics assessment focusing on financial data analysis. The assessment consists of four questions that tackle different aspects of customer data analysis for a financial services platform.

## Question 1: High-Value Customers with Multiple Products

### Approach
For this question, I needed to identify customers who have both a savings plan and an investment plan, then sort them by their total deposits.

The query:
1. Joins the users table with plans and savings account tables
2. Uses CASE statements within COUNT(DISTINCT) to separately count savings and investment plans
3. Filters with HAVING to ensure customers have at least one of each plan type
4. Orders by total deposits in descending order

### Challenges
The main challenge was understanding the relationship between regular savings plans and investment plans. Based on the hints provided, I identified that:
- `is_regular_savings = 1` indicates a savings plan
- `is_a_fund = 1` indicates an investment plan

## Question 2: Transaction Frequency Analysis

### Approach
This query categorizes customers based on their average monthly transaction frequency.

The implementation:
1. Creates a subquery to calculate each customer's average monthly transactions
2. Uses date calculations to determine how many months each customer has been active
3. Uses CASE statements to categorize customers into High, Medium, and Low frequency
4. Aggregates to count customers and calculate average transactions per category

### Challenges
The main challenge was calculating the accurate time period for each customer. Since we don't have the exact transaction dates in the sample data, I used the customer's join date to calculate how many months they've been active, then divided the total transaction count by this number.

## Question 3: Account Inactivity Alert

### Approach
Approach:
The solution uses a UNION ALL to combine results from two separate account types: savings and investments. For each:
1. Accounts are filtered to include only those with confirmed inflow (confirmed_amount > 0 for savings, amount > 0 for investments).
2. The most recent transaction date is derived using MAX(created_on).
3. Inactivity is calculated using DATEDIFF(CURDATE(), MAX(created_on)).
4. Only accounts inactive for over 365 days are included.

##Challenges & Considerations:
1. Determining a consistent method to define account activity across different table schemas.
2. Ensuring only accounts with actual inflow were considered, thereby excluding zero-fund or inactive-by-default accounts.
3. Aligning date-based logic consistently across both account types despite differing column structures.


## Question 4: Customer Lifetime Value (CLV) Estimation

### Approach
The CLV calculation follows the specified formula: (total_transactions / tenure) * 12 * avg_profit_per_transaction

Implementation steps:
1. Calculates tenure in months for each customer
2. Counts total transactions and sums transaction amounts
3. Applies the CLV formula using the 0.1% profit margin specified
4. Orders customers by estimated CLV in descending order

### Challenges
The main challenge was ensuring accurate mathematical operations, particularly:
1. Avoiding division by zero by filtering customers with tenure > 0
2. Correctly applying the profit margin (0.1% = 0.001)
3. Calculating the average profit per transaction properly

## General Notes
- All amount fields are in "kobo" (a minor currency unit) as specified in the hints
- Foreign keys are used to establish relationships between tables
- All queries include appropriate comments for clarity
- I've focused on making the SQL readable with consistent indentation and clear structure
