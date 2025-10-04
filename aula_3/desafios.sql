-- 1. Cria um relatório para todos os pedidos de 1996 e seus clientes (152 linhas)

Select c.contact_name, o.order_id
From orders as o
inner Join customers c 
	on c.customer_id = o.customer_id
Where extract(year FROM  order_date) = '1996'

-- 2. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem funcionários (5 linhas)

SELECT 
    e.city AS Cidade,
    COUNT(DISTINCT e.employee_id) AS Numero_Funcionarios,
    COUNT(DISTINCT c.customer_id) AS Numero_Clientes
FROM employees e
LEFT JOIN customers c
    ON c.city = e.city
GROUP BY e.city
ORDER BY e.city

-- 3. Cria um relatório que mostra o número de funcionários e clientes de cada cidade que tem clientes (69 linhas)

SELECT c.city AS Cidade,
	COUNT(DISTINCT c.customer_id) as Numero_Clientes,
	COUNT(DISTINCT e.employee_id) as Numero_Funcionarios
FROM customers c
LEFT JOIN employees e
	ON e.city = c.city
GROUP BY c.city
ORDER BY c.city

-- 4.Cria um relatório que mostra o número de funcionários e clientes de cada cidade (71 linhas)

SELECT c.city AS Cidade,
	COUNT(DISTINCT c.customer_id) as Numero_Clientes,
	COUNT(DISTINCT e.employee_id) as Numero_Funcionarios
FROM customers c
FULL JOIN employees e
	ON e.city = c.city
GROUP BY c.city, e.city
ORDER BY c.city

-- 5. Cria um relatório que mostra a quantidade total de produtos encomendados.
-- Mostra apenas registros para produtos para os quais a quantidade encomendada é menor que 200 (5 linhas)
WITH tProdutoResumo AS (
SELECT order_id, SUM(quantity) as SomaProdutos 
FROM ORDER_DETAILS
GROUP BY order_id
)
SELECT *
FROM tProdutoResumo
WHERE somaprodutos > 200

-- 6. Cria um relatório que mostra o total de pedidos por cliente desde 31 de dezembro de 1996.
-- O relatório deve retornar apenas linhas para as quais o total de pedidos é maior que 15 (5 linhas)
WITH tProdutosResumo AS 
(
SELECT order_id, SUM(quantity) as SomaProdutos 
FROM ORDER_DETAILS
GROUP BY order_id),
tClients AS 
(
SELECT customer_id, company_name
FROM customers
),
tOrdens AS 
(
SELECT  
	o.order_id,
	o.customer_id,
	cl.company_name,
	o.order_date,
	pr.SomaProdutos
FROM ORDERS o
Inner Join tProdutosResumo pr ON pr.order_id = o.order_id
Inner Join tClients cl ON cl.customer_id = o.customer_id
WHERE order_date >= '1996-12-31'
)
SELECT *
FROM tOrdens
WHERE somaprodutos > 15
