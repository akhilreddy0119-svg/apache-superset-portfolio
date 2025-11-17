SELECT
    queue_name,
    agent_name,
    DATE(created_at) AS created_date,
    COUNT(*) AS total_tickets,
    AVG(handle_time_minutes) AS avg_handle_time,
    SUM(CASE WHEN sla_breached = 'Yes' THEN 1 ELSE 0 END) AS breached_count,
    100.0 * SUM(CASE WHEN sla_breached = 'Yes' THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0) AS breached_pct,
    ROW_NUMBER() OVER (PARTITION BY queue_name ORDER BY AVG(handle_time_minutes)) AS agent_speed_rank
FROM operations_performance
WHERE status = 'Closed'
GROUP BY queue_name, agent_name, DATE(created_at)
ORDER BY queue_name, created_date;
