-- 1. Obter todas as colunas das tabelas Clientes, Pedidos e Fornecedores

Select * From customers;
Select * From orders;
Select * From employees;

-- 2. Obter todos os Clientes em ordem alfabética por país e nome

SELECT *
FROM customers
ORDER BY country, contact_name;

-- 3. Obter os 5 pedidos mais antigos

Select * 
From orders
ORDER BY order_date desc
Limit 5

-- 4. Obter a contagem de todos os Pedidos feitos durante 1997

Select Count(order_id) as TotalPedidos
From orders
Where EXTRACT(YEAR FROM order_date) = 1997;

SELECT COUNT(order_id) AS total_pedidos
FROM orders
WHERE order_date BETWEEN '1997-01-01' AND '1997-12-31';

-- 5. Obter os nomes de todas as pessoas de contato onde a pessoa é um gerente, em ordem alfabética

SELECT *
FROM customers
Where contact_title like '%Manager%'
ORDER BY contact_name;

-- 6. Obter todos os pedidos feitos em 19 de maio de 1997

SELECT *
FROM orders
WHERE order_date = '1997-05-19';