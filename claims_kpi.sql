SELECT
    claim_date::date AS claim_date,
    plan_name,
    channel,
    claim_status,
    SUM(paid_amount) AS total_paid,
    SUM(copay_amount) AS total_copay,
    COUNT(*) AS total_claims,
    DENSE_RANK() OVER (PARTITION BY plan_name ORDER BY SUM(paid_amount) DESC) AS plan_revenue_rank
FROM claims_kpi
GROUP BY claim_date::date, plan_name, channel, claim_status
ORDER BY claim_date::date, plan_name;
