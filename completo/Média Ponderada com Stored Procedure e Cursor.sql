-- ----------------------------------
## Tópicos Avançados em Banco		-
## de Dados - 14/05/2019			-
## Prof. Tarcísio Nunes				-
##									-
## Banco de dados de notas e		-
## médias ponderadas				-
## 21/05/2019
## Refartoramento com SP e Cursor	-
-- ----------------------------------
create database if not exists senai2019;
use senai2019;

#Entidades Principais
-- Tabela aluno
create table if not exists  aluno(
	idAluno int primary key auto_increment,
    nome varchar(40) not null,
    dtNasc date
);

-- Populando a tabela aluno
insert into aluno values
(1,'UM um um','2000-05-14'),
(2,'DOIS dois dois','1999-03-20'),
(3,'TRÊS três três','2001-07-01');#CTRL ENTER

-- Tabela Unidade Curricular UCr
create table if not exists UCr(
	idUCr int primary key auto_increment,
    nome varchar(40)
);

-- Populando a tabela UCr
insert into UCr values
(1,'Análise de Sistema'),
(2,'Engenharia de Software'),
(3,'Introdução à Prog. Web'),
(4,'Metodologia de Projetos'),
(5,'Tópicos Avançados em BD');#CTRL ENTER

-- Tabela de Provas
create table if not exists prova(
	idProva int primary key auto_increment,
    idUCr int,
    nome varchar(40),
    descricao text,
    peso decimal(3,2),
    dtProva date,
    foreign key(idUCr) references UCr(idUCr)
);
SELECT * FROM prova;
-- Criando provas
insert into prova value
-- (1,'Análise de Sistema'),
(1,1,'Prova 1 de AS','Desc P1AS',0.2,'2019-05-20'),
(2,1,'Prova 2 de AS','Desc P2AS',0.8,'2019-05-27'),
-- (2,'Engenharia de Software'),
(3,2,'Prova 1 de Eng. Sw','Desc P1ES',1,'2019-04-03'),
(4,2,'Prova 2 de Eng. Sw','Desc P2ES',1,'2019-03-30'),
(5,2,'Prova 3 de Eng. Sw','Desc P3ES',1,'2019-05-23'),
-- (5,'Tópicos Avançados em BD')
(6,5,'Prova 1 de TABD','DESC TABD P1',0.1,'2019-06-07'),
(7,5,'Prova 2 de TABD','DESC TABD P2',0.1,'2019-06-17'),
(8,5,'Prova 3 de TABD','DESC TABD P3',0.1,'2019-06-27'),
(9,5,'Prova 4 de TABD','DESC TABD P4',0.7,'2019-07-07');

-- Tabela de Notas
create table if not exists nota(
	idProva int,
    idAluno int,
    valor decimal(4,2),
    primary key(idProva,idAluno),
    foreign key(idProva) references prova(idProva),
    foreign key(idAluno) references aluno(idAluno)
);#CTRL ENTER

select * from nota;
-- Inserindo as notas
insert into nota values
-- #(1,'Análise de Sistema'),
-- (1,1,'Prova 1 de AS','Desc P1AS',0.2,'2019-05-20'),
(1,1,6.7), -- Aluno 1
(1,2,7.8), -- Aluno 2
(1,3,5.7), -- Aluno 3
-- (2,1,'Prova 2 de AS','Desc P2AS',0.8,'2019-05-27'),
(2,1,9.7), -- Aluno 1
(2,2,4.8), -- Aluno 2
(2,3,9.7), -- Aluno 3
-- #(2,'Engenharia de Software'),
-- (3,2,'Prova 1 de Eng. Sw','Desc P1ES',1,'2019-04-03'),
(3,1,4.7), -- Aluno 1
(3,2,10), -- Aluno 2
(3,3,5), -- Aluno 3
-- (4,2,'Prova 2 de Eng. Sw','Desc P2ES',1,'2019-03-30'),
(4,1,5.7), -- Aluno 1
(4,2,9.8), -- Aluno 2
(4,3,6), -- Aluno 3
-- (5,2,'Prova 3 de Eng. Sw','Desc P3ES',1,'2019-05-23'),
(5,1,7.7), -- Aluno 1
(5,2,7.1), -- Aluno 2
(5,3,5.5), -- Aluno 3
-- #(5,'Tópicos Avançados em BD')
-- (6,5,'Prova 1 de TABD','DESC TABD P1',0.1,'2019-06-07'),
(6,1,4), -- Aluno 1
(6,2,4), -- Aluno 2
(6,3,4), -- Aluno 3
-- (7,5,'Prova 2 de TABD','DESC TABD P2',0.1,'2019-06-17'),
(7,1,8.7), -- Aluno 1
(7,2,8.8), -- Aluno 2
(7,3,8.5), -- Aluno 3
-- (8,5,'Prova 3 de TABD','DESC TABD P3',0.1,'2019-06-27'),
(8,1,6.7), -- Aluno 1
(8,2,6.1), -- Aluno 2
(8,3,6.5), -- Aluno 3
-- (9,5,'Prova 4 de TABD','DESC TABD P4',0.7,'2019-07-07');
(9,1,8.7), -- Aluno 1
(9,2,8.1), -- Aluno 2
(9,3,5.9); -- Aluno 3

-- ------------
-- Consultas --
-- ------------
select * from nota;
select * from prova;

#Dado o id da UCr, qual o id das provas?
select idProva from prova where idUcr = 1;
select idProva from prova where idUcr = 2;
select idProva from prova where idUcr = 3;
select idProva from prova where idUcr = 4;
select idProva from prova where idUcr = 5;

#Notas de um aluno em uma unidade curricular?
select * from nota where 
idAluno = 3 AND
idProva IN (select idProva from prova where idUcr = 5);

#Mostrar as notas de um aluno em uma unidade curricular
#e o seus pesos
select n.*, peso from nota n
inner join prova using(idProva)
where idAluno = 3 AND
idProva IN (select idProva from prova where idUcr = 5);

#Multiplicando Nota x Peso
select n.*, peso, n.valor*peso as notaPonderada
from nota n
inner join prova using(idProva)
where idAluno = 3 AND
idProva IN (select idProva from prova where idUcr = 5);

#Cálculo da Média ponderada para Um aluno e
#uma unidade curricular
select sum(n.valor*peso) as somaNotaPonderada,
	   sum(peso) as somaPeso, 
       round(sum(n.valor*peso)/sum(peso),2) as média
from nota n
inner join prova using(idProva)
where idAluno = 3 AND
idProva IN (select idProva from prova where idUcr = 5);

#Mostrar o nome da unidade curricular
select ucr.nome, 
       round(sum(n.valor*peso)/sum(peso),2) as média
from nota AS n -- Apelido
inner join prova using(idProva)
-- inner join ucr on prova.idUCR = ucr.iducr
inner join ucr using(idUcr)
where idAluno = 3 AND
idProva IN (select idProva from prova where idUcr = 5);

#Mostrar o nome da unidade curricular e o nome do aluno
#seguidos da média
select ucr.nome as UCr, -- Nome da UCr
	   aluno.nome as Aluno,	-- Nome do Aluno
       round(sum(n.valor*peso)/sum(peso),2) as média
from nota n
inner join prova using(idProva)
inner join ucr using(idUcr)
inner join aluno using(idAluno)
where idAluno = 1 AND
idProva IN (select idProva from prova where idUcr = 5);

#Média de todas unidades curriculares para um aluno
create view MediaUcr as
select ucr.nome, 
       round(sum(n.valor*peso)/sum(peso),2) as média
from nota n
inner join prova using(idProva)
-- inner join ucr on prova.idUCR = ucr.iducr
inner join ucr using(idUcr)
where idAluno = 3 AND
idProva IN (select idProva from prova where idUcr = 1)

UNION -- Unindo selects para o bem da nação

select ucr.nome, 
       round(sum(n.valor*peso)/sum(peso),2) as média
from nota n
inner join prova using(idProva)
-- inner join ucr on prova.idUCR = ucr.iducr
inner join ucr using(idUcr)
where idAluno = 3 AND
idProva IN (select idProva from prova where idUcr = 2)

UNION

select ucr.nome, 
       round(sum(n.valor*peso)/sum(peso),2) as média
from nota n
inner join prova using(idProva)
-- inner join ucr on prova.idUCR = ucr.iducr
inner join ucr using(idUcr)
where idAluno = 3 AND
idProva IN (select idProva from prova where idUcr = 5);

#Média de todos alunos para uma unidade curricular

create view MediaALunos as
select aluno.nome, 
       round(sum(n.valor*peso)/sum(peso),2) as média
from nota n
inner join prova using(idProva)
-- inner join ucr on prova.idUCR = ucr.iducr
inner join aluno using(idAluno)
where idAluno = 1 AND
idProva IN (select idProva from prova where idUcr = 5)
union
select aluno.nome, 
       round(sum(n.valor*peso)/sum(peso),2) as média
from nota n
inner join prova using(idProva)
-- inner join ucr on prova.idUCR = ucr.iducr
inner join aluno using(idAluno)
where idAluno = 2 AND
idProva IN (select idProva from prova where idUcr = 5)
union
select aluno.nome, 
       round(sum(n.valor*peso)/sum(peso),2) as média
from nota n
inner join prova using(idProva)
-- inner join ucr on prova.idUCR = ucr.iducr
inner join aluno using(idAluno)
where idAluno = 3 AND
idProva IN (select idProva from prova where idUcr = 5);

-- ----------
-- Mostrando as Views
select * from mediaAlunos; -- Visão dos Professores
select * from mediaUCr; -- Visão dos Alunos

#######################
## Stored Procedures ##
#######################
-- http://www.mysqltutorial.org/getting-started-with-mysql-stored-procedures.aspx

DELIMITER $$
CREATE PROCEDURE getAlunos()
BEGIN
	SELECT * FROM aluno;
END$$ #CTRL ENTER
DELIMITER ;

call getAlunos();

DELIMITER $$
CREATE PROCEDURE `getUCr`()
BEGIN
	SELECT * FROM UCr;
END$$ #CTRL ENTER
DELIMITER ;

call getucr();

SELECT * FROM prova;
-- Faça um SP que com parâmetro de entrada
-- o ID da UCr e entao retorna o nome da
-- UCr seguido das provas;

-- Parâmetro de Entrada
DELIMITER $$
CREATE PROCEDURE getProvasUcr(IN id int)
BEGIN
	select u.nome, p.* from prova p
	inner join UCr u using(idUCr)
	where idUCr = id;#Parâmetro de Entrada
END$$ #CTRL ENTER
DELIMITER ;

call getProvasUcr(1);
call getProvasUcr(2);
call getProvasUcr(3);
call getProvasUcr(4);
call getProvasUcr(5);

-- 1º passo
select * from prova;
-- 2º Passo
select * from prova where idUCr = 5;
-- 3º Passo
select u.nome, p.* from prova p
inner join UCr u using(idUCr)
where idUCr = 5;
-- 4º Passo
-- Jogar para dentro da SP

-- Parâmetro de Saída
DELIMITER $$
CREATE PROCEDURE contadorAlunos
(OUT contador INT)
BEGIN
	SELECT COUNT(*) INTO contador
    FROM aluno;
END$$ #CTRL ENTER
DELIMITER ;
-- Variável Global/Sessão com @ antes do nome
call contadorAlunos(@total);
select @total as 'Total de ALunos';

-- ------------------------------
-- SP para geração dinâmica de  -
-- de SELECT com UNION e CURSOR -
-- ------------------------------

DELIMITER $$
CREATE PROCEDURE getMediaAluno(IN id int) -- ID DO ALUNO
BEGIN
	DECLARE varIdUCr INT DEFAULT 0;-- Variável
    DECLARE finalizadorDeCursor INT DEFAULT 0;-- Flag para finalizar Cursor
    
    -- Declaração do Cursor para buscar os ID das UCrs
    DECLARE ucrCursor CURSOR FOR
    SELECT DISTINCT idUCR FROM prova;
    
    -- Se nada mais for encontrado, finaliza o cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
    SET finalizadorDeCursor = 1; -- Flag
    
    SET @SQL = ''; -- Vai receber o comando SQL gerado
    
    -- Abrindo o cursor
    OPEN ucrCursor;
    
    -- Inicia o Laço
    geraSQL: LOOP
		-- Consumindo o cursor
        FETCH ucrCursor INTO varIdUCr;
        
        IF finalizadorDeCursor = 1 THEN
			LEAVE geraSQL; -- SAI DO LOOP
		END IF;
        
        IF @SQL = '' THEN
			SET @SQL = CONCAT('select ucr.nome, 
		round(sum(n.valor*peso)/sum(peso),2) as média
		from nota n
		inner join prova using(idProva)
		-- inner join ucr on prova.idUCR = ucr.iducr
		inner join ucr using(idUcr)
		where idAluno =',ID,' AND -- ID PARÂMETRO DE ENTRADA
		idProva IN (select idProva from prova where idUcr =', varIdUCr,')');
		ELSE
			SET @SQL = CONCAT(@SQL,' UNION select ucr.nome, 
		round(sum(n.valor*peso)/sum(peso),2) as média
		from nota n
		inner join prova using(idProva)
		-- inner join ucr on prova.idUCR = ucr.iducr
		inner join ucr using(idUcr)
		where idAluno =',ID,' AND -- ID PARÂMETRO DE ENTRADA
		idProva IN (select idProva from prova where idUcr =', varIdUCr,')');
		END IF;
                    	
    END LOOP geraSQL;
    CLOSE ucrCursor; -- FECHA O CURSOR
    
    -- Prepared statment
    -- https://dev.mysql.com/doc/refman/8.0/en/sql-syntax-prepared-statements.html
    -- Para executar o SQL gerado acima no cursor
    PREPARE comando FROM @SQL;
    EXECUTE comando; 
    DEALLOCATE PREPARE comando;    
    
END$$ #CTRL ENTER
DELIMITER ;

-- Busca de IDs das UCRs com provas cadastradas
select distinct idUcr from prova;

-- Chamando a procedure para um aluno
call getMediaAluno(3);













