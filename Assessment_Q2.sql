/*
* Question 2: Transaction Frequency Analysis
* Calculate the average number of transactions per customer per month and categorize them into
* frequency categories: High (≥10), Medium (3-9), Low (≤2)
*/

-- First calculate transactions per month for each customer and categorize them
WITH customer_frequency AS (
    SELECT 
        u.id AS user_id,
        u.name,
        COUNT(s.id) / 
            GREATEST(1, TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE)) AS transactions_per_month,
        CASE 
            WHEN COUNT(s.id) / GREATEST(1, TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE)) >= 10 THEN 'High Frequency'
            WHEN COUNT(s.id) / GREATEST(1, TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE)) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM 
        users_customuser u
    JOIN 
        plans_plan p ON u.id = p.owner_id
    JOIN 
        savings_savingsaccount s ON p.id = s.plan_id
    WHERE 
        s.confirmed_amount > 0  -- Only count actual transactions
    GROUP BY 
        u.id, u.name
)

-- Then aggregate by frequency category
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(transactions_per_month), 1) AS avg_transactions_per_month
FROM 
    customer_frequency
GROUP BY 
    frequency_category
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        ELSE 3
    END;
