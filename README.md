# DataAnalytics-Assessment

# Data Analytics SQL Assessment

This project includes SQL queries solving four business problems using customer and transaction data.

---

## Question 1: High-Value Customers with Multiple Products
**Goal:** Identify users with at least one funded savings plan and one funded investment plan, sorted by total deposits.

**Approach:**
- Joined `users_customuser`, `savings_savingsaccount`, and `plans_plan`.
- Filtered for `is_regular_savings = 1` and `is_a_fund = 1`.
- Calculated total deposits in Naira (`confirmed_amount / 100`).

---

## Question 2: Transaction Frequency Analysis
**Goal:** Categorize customers by monthly transaction frequency.

**Approach:**
- Aggregated transactions per month.
- Categorized into:
  - High (≥10/month)
  - Medium (3–9/month)
  - Low (≤2/month)

---

## Question 3: Account Inactivity Alert
**Goal:** Flag accounts with no inflows for over 1 year.

**Approach:**
- Used `created_on` to determine last transaction date.
- Checked inactivity > 365 days for both savings and investment plans.

---

## Question 4: Customer Lifetime Value (CLV) Estimation
**Goal:** Estimate CLV using transaction count, tenure, and value.

**Approach:**
- Tenure: Months since signup.
- Total transactions and total transaction value.
- CLV: `(transactions / tenure) * 12 * avg_profit (0.1%)`.

---

## Challenges
- Lack of provided schema initially.
- Needed to infer foreign key relations and data types.
- Adjusted for SQL Server syntax (e.g., `GETDATE()`, `DATEDIFF`).
- Ensured amount fields were converted from kobo to Naira.

---

## Notes
- All amounts are assumed to be in **kobo**, hence divided by 100 for Naira.
- Queries were tested assuming typical field types and naming from the questions.
