-- Total de receitas de 1997?

EXPLAIN ANALYZE

SELECT Sum((o.unit_price * o.quantity) * (1 - o.discount)) as TotalReceita
FROM order_details AS o
JOIN orders AS os ON os.order_id = o.order_id
WHERE EXTRACT(YEAR FROM os.order_date) = 1997

