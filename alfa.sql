CREATE TABLE tb_filiais(
cod_filial SERIAL PRIMARY KEY,
cnpj_filial varchar(15),
nome_filial varchar(25),
cidade_filial varchar(25),
uf_filial varchar(2)
);

CREATE TABLE tb_departamentos(
cod_depart SERIAL PRIMARY KEY,
nome_depart varchar(25),
cod_filial int NOT NULL,
FOREIGN KEY (cod_filial) REFERENCES tb_filiais (cod_filial)
);

CREATE TABLE tb_colab(
cpf_colab varchar(11) PRIMARY KEY,
nome_colab varchar(50),
gen_colab varchar(1) CONSTRAINT tipo_gen CHECK(gen_colab = ANY (ARRAY['F', 'M'])),
ad_colab date,
sal_colab int NOT NULL,
cod_depart int NOT NULL,
FOREIGN KEY (cod_depart) REFERENCES tb_departamentos (cod_depart)
);

INSERT INTO tb_filiais (cnpj_filial, nome_filial, cidade_filial, uf_filial)
VALUES
('82110818000121', 'ALFA TRANSPORTES EIRELI', 'Caçador', 'SC'),
('82110818000202', 'ALFA TRANSPORTES EIRELI', 'Curitiba', 'PR'),
('82110818000393', 'ALFA TRANSPORTES EIRELI', 'Guarulhos', 'SP'),
('82110818001608', 'ALFA TRANSPORTES EIRELI', 'Betim', 'MG'),
('82110818000806', 'ALFA TRANSPORTES EIRELI', 'Cachoeirinha', 'RS'),
('82110818002760', 'ALFA TRANSPORTES EIRELI', 'Tres Lagoas', 'MS'),
('82110818002094', 'ALFA TRANSPORTES EIRELI', 'Goiania', 'GO'),
('82110818002507', 'ALFA TRANSPORTES EIRELI', 'Serra', 'ES'),
('82110818002841', 'ALFA TRANSPORTES EIRELI', 'Rio de Janeiro', 'RJ');

INSERT INTO tb_departamentos (cod_filial, nome_depart) 
(SELECT cod_filial, unnest(array['Expedicao','SAC','Operacional','Administrativo','Gerência']) FROM tb_filiais);

INSERT INTO tb_colab
VALUES
('37738319003',	'nome01', 'F', '2021-10-05', 1550,	1),
('37738319004',	'nome02', 'M', '2020-08-15', 2030,	2),
('37738319005',	'nome03', 'F', '2019-06-26', 3000,	3),
('37738319006',	'nome04', 'M', '2018-05-06', 2500,	7),
('37738319007',	'nome05', 'F', '2017-03-16', 3225,	8),
('37738319008',	'nome06', 'M', '2016-01-25', 3607,	9),
('37738319009',	'nome07', 'F', '2014-12-05', 3989,	11),
('37738319010',	'nome08', 'M', '2013-10-15', 4371,	12),
('37738319011',	'nome09', 'F', '2012-08-25', 4753,	13),
('37738319012',	'nome10', 'M', '2011-07-06', 5135,	18),
('37738319013',	'nome11', 'F', '2010-05-16', 5517,	19),
('37738319014',	'nome12', 'M', '2009-03-26', 5899,	20),
('37738319015',	'nome13', 'F', '2008-02-04', 6281,	22),
('37738319016',	'nome14', 'M', '2006-12-15', 6663,	23),
('37738319017',	'nome15', 'F', '2005-10-25', 7045,	24),
('37738319018',	'nome16', 'M', '2004-09-04', 7427,	28),
('37738319019',	'nome17', 'F', '2003-07-16', 7809,	29),
('37738319020',	'nome18', 'M', '2002-05-26', 8191,	30),
('37738319021',	'nome19', 'F', '2001-04-05', 8573,	34),
('37738319022',	'nome20', 'M', '2000-02-14', 8955,	35),
('37738319023',	'nome21', 'F', '1998-12-25', 9337,	36),
('37738319024',	'nome22', 'M', '1997-11-04', 9719,	38),
('37738319025',	'nome23', 'F', '1996-09-14', 10101,	39),
('37738319026',	'nome24', 'M', '1995-07-26', 10483,	40),
('37738319027',	'nome25', 'F', '1994-06-05', 10865,	41),
('37738319028',	'nome26', 'M', '1993-04-15', 11247,	42),
('37738319029',	'nome27', 'F', '1992-02-24', 11629,	43);

SELECT cpf_colab, nome_colab, tb_departamentos.nome_depart, tb_filiais.cidade_filial 
FROM tb_colab
LEFT JOIN tb_departamentos
ON tb_departamentos.cod_depart = tb_colab.cod_depart
LEFT JOIN tb_filiais
ON tb_filiais.cod_filial = tb_departamentos.cod_filial
ORDER BY tb_filiais.cod_filial, nome_colab

SELECT cpf_colab, nome_colab, ad_colab, tb_filiais.cidade_filial
FROM tb_colab
LEFT JOIN tb_departamentos
ON tb_departamentos.cod_depart = tb_colab.cod_depart
LEFT JOIN tb_filiais
ON tb_filiais.cod_filial = tb_departamentos.cod_filial
ORDER BY ad_colab LIMIT 5

SELECT
COUNT (cpf_colab) as quantidade_filial
FROM 
tb_colab
LEFT JOIN 
tb_departamentos
ON tb_departamentos.cod_filial = tb_filiais.cod_filial 
WHERE tb_departamentos.cod_filial = 1;

SELECT
tb_filiais.cod_filial, tb_filiais.cidade_filial,
COUNT (cpf_colab) as quantidade_filial
FROM 
tb_colab
LEFT JOIN 
tb_departamentos
ON tb_departamentos.cod_depart = tb_colab.cod_depart 
LEFT JOIN
tb_filiais
ON tb_filiais.cod_filial = tb_departamentos.cod_filial
GROUP BY tb_filiais.cod_filial, tb_filiais.cidade_filial
ORDER BY tb_filiais.cod_filial;

SELECT 
tb_departamentos.nome_depart,
trunc (AVG (sal_colab),2) as media_salario
FROM
tb_colab
LEFT JOIN
tb_departamentos
ON tb_departamentos.cod_depart = tb_colab.cod_depart 
GROUP BY tb_departamentos.nome_depart;