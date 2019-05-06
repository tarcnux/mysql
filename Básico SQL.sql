/* Criação da tabela aluno */
CREATE TABLE aluno(
    id integer primary key auto_increment,
    nome text,
    email text,
    nota1 real,
    nota2 real
);

/*Inserindo dados na tabela aluno*/
INSERT INTO aluno(id, nome, email, nota1, nota2)
VALUES(1,'Gilmara','gil@hotmail.com',9.8,7.8);

/*Inserindo dados omitindo os campos*/
INSERT INTO aluno
VALUES(NULL,'Cacildo','cac@gmail.com',4.6,7.8);

/*Inserindo dados em campos específicos*/
INSERT INTO aluno(nome,nota1,nota2) VALUES('Ronilson',4.7,5.6);

/**********************
* Consultando dados
**********************/
SELECT * FROM aluno;

/*Consulta com filtro usando cláusula WHERE*/
SELECT * FROM aluno WHERE email is null;

/*Atualizar o registro do aluno sem e-mail*/
UPDATE aluno SET email = 'roni@bol.com.br' where id = 6; 
SELECT * FROM aluno;

delete from aluno where id > 2 AND id < 6;

/*Consulta de campos específicos*/
SELECT nome,nota1,nota2 FROM aluno;

/* Ajuste a nota 1 do Ronilson para 7.4 */ 
UPDATE aluno set nota1 = 7.4 WHERE id = 6;

/* Cadastre o novo aluno Marilson com notas 8 e 6*/
INSERT INTO aluno(nome,nota1,nota2)
VALUES('Marilson',8,6);

/*Listando em ordem alfabética*/
SELECT * FROM aluno ORDER BY nome;

/*Consulta de campos específicos com apelidos
e cálculo de média, criando um novo campo*/
SELECT nome AS NOME,
       nota1 AS 'Nota 1',
       nota2 AS 'Nota 2',
       round((nota1+nota2)/2,1) AS Média
       FROM aluno;

/*Ordenando pela maior média*/
SELECT nome AS NOME,
       nota1 AS 'Nota 1',
       nota2 AS 'Nota 2',
       round((nota1+nota2)/2,1) AS Média
       FROM aluno ORDER BY Média DESC;/*Descendente*/

/* Excluir a Gilmara da turma! */
DELETE FROM aluno WHERE id = 1;

/*MOSTRANDO apenas nome e média, Limitando apenas a maior média*/
SELECT nome AS NOME,
       round((nota1+nota2)/2,1) AS Média
       FROM aluno ORDER BY Média DESC LIMIT 1;
       
