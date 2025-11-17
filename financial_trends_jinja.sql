SELECT
    DATE(transaction_date) AS txn_date,
    region,
    product_line,
    SUM(revenue) AS total_revenue,
    SUM(cost) AS total_cost
FROM financial_trends
WHERE region IN (
    {{ "'" + "','".join(filter_values("region")) + "'" if filter_values("region") else "'East','West','North','South'" }}
)
GROUP BY DATE(transaction_date), region, product_line
ORDER BY txn_date, region, product_line;
