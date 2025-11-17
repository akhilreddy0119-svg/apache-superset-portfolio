SELECT
    queue_name,
    DATE(created_at) AS created_date,
    COUNT(*) AS total_tickets,
    AVG(handle_time_minutes) AS avg_handle_time
FROM operations_performance
WHERE queue_name IN (
    {{ "'" + "','".join(filter_values("queue_name")) + "'" if filter_values("queue_name") else "'Prior Auth','Claims Review','Customer Support'" }}
)
GROUP BY queue_name, DATE(created_at)
ORDER BY created_date, queue_name;
