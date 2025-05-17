/*
* Question 4: Customer Lifetime Value (CLV) Estimation
* Calculate CLV based on account tenure and transaction volume
* CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction
* Where profit_per_transaction is 0.1% of transaction value
*/

SELECT 
    u.id AS customer_id,
    u.name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND(
        (COUNT(s.id) / TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE)) * 12 * 
        (SUM(s.confirmed_amount) * 0.001 / COUNT(s.id)),
        2
    ) AS estimated_clv
FROM 
    users_customuser u
JOIN 
    plans_plan p ON u.id = p.owner_id
JOIN 
    savings_savingsaccount s ON p.id = s.plan_id
WHERE 
    s.confirmed_amount > 0  -- Only count actual transactions
GROUP BY 
    u.id, u.name, u.date_joined
HAVING 
    tenure_months > 0  -- Avoid division by zero
ORDER BY 
    estimated_clv DESC;
