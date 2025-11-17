SELECT
    claim_date::date AS claim_date,
    plan_name,
    state,
    SUM(paid_amount) AS total_paid,
    COUNT(*) AS total_claims
FROM claims_kpi
WHERE claim_date::date BETWEEN
    '{{ filter_values("start_date")[0] if filter_values("start_date") else "2024-01-01" }}'
    AND
    '{{ filter_values("end_date")[0] if filter_values("end_date") else "2024-12-31" }}'
GROUP BY claim_date::date, plan_name, state
ORDER BY claim_date::date, plan_name;
