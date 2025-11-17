SELECT
    DATE(transaction_date) AS txn_date,
    region,
    product_line,
    SUM(revenue) AS total_revenue,
    SUM(cost) AS total_cost,
    SUM(revenue - cost) AS total_profit,
    LAG(SUM(revenue)) OVER (PARTITION BY region ORDER BY DATE(transaction_date)) AS prev_revenue,
    SUM(SUM(revenue)) OVER (PARTITION BY region ORDER BY DATE(transaction_date)) AS cumulative_revenue
FROM financial_trends
GROUP BY DATE(transaction_date), region, product_line
ORDER BY txn_date, region, product_line;
