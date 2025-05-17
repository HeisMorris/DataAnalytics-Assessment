/*
* Question 3: Account Inactivity Alert
* Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days)
*/

-- Select inactive savings accounts
SELECT
    s.id AS plan_id,
    s.owner_id,
    'Savings' AS type,
    MAX(s.created_on) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(s.created_on)) AS inactivity_days
FROM savings_savingsaccount s
WHERE s.confirmed_amount > 0
GROUP BY s.id, s.owner_id
HAVING DATEDIFF(CURDATE(), MAX(s.created_on)) > 365

UNION ALL

-- Select inactive investment plans
SELECT
    p.id AS plan_id,
    p.owner_id,
    'Investment' AS type,
    MAX(p.created_on) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(p.created_on)) AS inactivity_days
FROM plans_plan p
WHERE p.amount > 0    -- Only consider plans with actual funds
GROUP BY p.id, p.owner_id
HAVING DATEDIFF(CURDATE(), MAX(p.created_on)) > 365;   -- Filter to only include plans inactive for over 1 year



