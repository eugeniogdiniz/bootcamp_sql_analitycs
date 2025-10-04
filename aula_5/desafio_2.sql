-- FAÇA UMA ANÁLISE DE CRESCIMENTO MENSAL E O CÁLCULO DE YTD
-- RECEITAS MENSAIS

WITH ReceitasMensais AS (
	SELECT 
		EXTRACT(YEAR FROM o.order_date) AS Ano,
		EXTRACT(MONTH FROM o.order_date) AS Mes,
		Sum((os.unit_price * os.quantity) * (1 - os.discount)) as ReceitaMensal
	FROM orders AS o
	INNER JOIN order_details AS os ON os.order_id = o.order_id
	GROUP BY 1,2
),
ReceitasMensaisYTD AS (
	SELECT
		Ano,
		Mes,
		ReceitaMensal,
		SUM(ReceitaMensal) OVER (PARTITION BY Ano ORDER BY Mes) AS Receita_YTD
	FROM ReceitasMensais
)
SELECT 
	Ano,
	Mes,
	ReceitaMensal,
	ReceitaMensal - LAG(ReceitaMensal) OVER (PARTITION BY Ano ORDER BY Mes) AS Diferenca_Mensal,
	Receita_YTD,
	(ReceitaMensal - LAG(ReceitaMensal) OVER (PARTITION BY Ano ORDER BY Mes)) /  
		LAG(ReceitaMensal) OVER (PARTITION BY Ano ORDER BY Mes) * 100 AS Percentual
FROM 
	ReceitasMensaisYTD
ORDER BY 
	1,2