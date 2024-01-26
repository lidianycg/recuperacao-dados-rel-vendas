ALTER TABLE database_0 RENAME COLUMN c1 TO data;
ALTER TABLE database_0 RENAME COLUMN c2 TO id_marca;
ALTER TABLE database_0 RENAME COLUMN c3 TO vendas;
ALTER TABLE database_0 RENAME COLUMN c4 TO valor_do_veiculo;
ALTER TABLE database_0 RENAME COLUMN c5 TO nome;

SELECT * FROM database_0;
SELECT * FROM database_1;

ALTER TABLE database_1 RENAME COLUMN c1 TO id_marca;
ALTER TABLE database_1 RENAME COLUMN c2 TO marca;

SELECT * FROM database_1;

CREATE TABLE database_2 AS
SELECT
    db0.data AS data,
    db0.id_marca AS id_marca,
    db0.vendas AS vendas,
    db0.valor_do_veiculo AS valor_do_veiculo,
    db0.nome AS nome,
    db1.marca AS marca
FROM
    database_0 AS db0
INNER JOIN
    database_1 AS db1 ON db0.id_marca = db1.id_marca;
   
 DROP TABLE database_0;
 DROP TABLE database_1;
 DROP TABLE demo;
 
 SELECT * FROM database_2;
 
SELECT
    marca,
    SUM(vendas) AS volume_de_vendas
FROM
    database_2
GROUP BY
    marca
ORDER BY
    volume_de_vendas DESC
LIMIT 1;

SELECT 
	nome,
    SUM(valor_do_veiculo * vendas) AS receita_vendas
FROM
    database_2
GROUP BY
    marca
ORDER BY
    receita_vendas ASC
LIMIT 1;


SELECT
    marca,
    AVG(vendas) AS media_de_vendas
FROM
    database_2
GROUP BY
    marca;
    
SELECT
    marca,
    SUM(vendas) AS total_de_vendas,
    SUM(vendas * valor_do_veiculo) AS receita_total
FROM
    database_2
GROUP BY
    marca
ORDER BY
    receita_total DESC;
    
   
 
SELECT
    nome,
    SUM(vendas) AS total_de_vendas
FROM
    database_2
GROUP BY
    nome
ORDER BY
    total_de_vendas DESC;
    

SELECT
    nome,
    SUM(vendas) AS total_de_vendas, valor_do_veiculo
FROM
    database_2
GROUP BY
    nome
ORDER BY
    total_de_vendas DESC;
    
