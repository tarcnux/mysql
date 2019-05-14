delimiter $
create procedure proc()
begin
	select "Alo Ha mundo";
end$

delimiter ;
show procedure status;
drop procedure proc;
call proc();

delimiter $
create function func() returns varchar(100)
begin
	return "Alo Ha Mundo";
end$

delimiter ;
show function status;
drop function func;

create table aluno(
	idAluno int primary key auto_increment,
    nome varchar(100),
    matricula varchar(45),
    data_nascimento date,
    data_matricula date
);

insert into aluno values
(1,'Um Um Um', '111','2000-07-30',current_date()),
(2,'dois dois dois', '222','2000-05-04',current_date()),
(3,'Três Três Três', '333','1999-01-22',current_date());

select * from aluno;

create table ucr(
	idUcr int primary key auto_increment,
    nome varchar(40)
);

insert into ucr values
(1,'Tópicos Avançados em Banco de Dados'),
(2,'Introdução à Programação Web'),
(3,'Análise de Sistemas'),
(4,'Engenharia de Software'),
(5,'Metodologia de projetos');

create table prova(
	idProva int primary key auto_increment,
    idUcr int,
    data_realização date,
    descrição text,
    peso real,
    foreign key(idUcr) references ucr(idUcr)
);

insert into prova values
-- (1,'Tópicos Avançados em Banco de Dados'),
(1,1, '2019-05-07', 'teste 1 BD', 1),
(2,1, '2019-05-10', 'teste 2 BD', 1),
(3,1, '2019-05-14', 'teste 3 BD', 1),
-- (2,'Introdução à Programação Web'),
(4,2, '2019-05-14', 'teste 1 IPW', 0.7),
(5,2, '2019-05-15', 'teste 2 IPW', 0.3),
-- (3,'Análise de Sistemas'),
(6,3, '2019-05-20', 'teste 1 AS', 0.1),
(7,3, '2019-05-21', 'teste 2 AS', 0.1),
(8,3, '2019-05-22', 'teste 3 AS', 0.5),
(9,3, '2019-05-23', 'teste 4 AS', 0.3),
-- (4,'Engenharia de Software'),
(10,4, '2019-05-20', 'teste 1 ES', 0.1),
(11,4, '2019-05-21', 'teste 2 ES', 0.1),
(12,4, '2019-05-22', 'teste 3 ES', 0.4),
(13,4, '2019-05-23', 'teste 4 ES', 0.1),
(14,4, '2019-05-23', 'teste 5 ES', 0.3);


create table nota(
	idAluno int,
    idProva int,
    valor real,   
    primary key(idAluno,idProva),
    foreign key(idAluno) references aluno(idAluno),
    foreign key(idProva) references prova(idProva)
);

insert into nota values
-- Aluno 1 Um
-- (1,'Tópicos Avançados em Banco de Dados'),
(1,1,6.6),
(1,2,7.7),
(1,3,8.8),
-- (2,'Introdução à Programação Web'),
(1,4,4.6),
(1,5,5.7),
-- (3,'Análise de Sistemas'),
(1,6,7.6),
(1,7,8.7),
(1,8,9.6),
(1,9,2.7),
-- (4,'Engenharia de Software'),
(1,10,4.6),
(1,11,5.7),
(1,12,6.6),
(1,13,7.7),
(1,14,8.7),

-- Aluno 2 Dois
-- (1,'Tópicos Avançados em Banco de Dados'),
(2,1,3.6),
(2,2,4.7),
(2,3,9.8),
-- (2,'Introdução à Programação Web'),
(2,4,5.6),
(2,5,7.7),
-- (3,'Análise de Sistemas'),
(2,6,9.6),
(2,7,9.7),
(2,8,9.6),
(2,9,9.7),
-- (4,'Engenharia de Software'),
(2,10,5.6),
(2,11,5.7),
(2,12,5.6),
(2,13,5.7),
(2,14,4.7),


-- Aluno 3 Três
-- (1,'Tópicos Avançados em Banco de Dados'),
(3,1,3.6),
(3,2,4.7),
(3,3,9.8),
-- (2,'Introdução à Programação Web'),
(3,4,5.6),
(3,5,7.7),
-- (3,'Análise de Sistemas'),
(3,6,9.6),
(3,7,9.7),
(3,8,9.6),
(3,9,9.7),
-- (4,'Engenharia de Software'),
(3,10,5.6),
(3,11,5.7),
(3,12,5.6),
(3,13,5.7),
(3,14,6.7);

-- IDs das provas da UCr 1
-- (1,'Tópicos Avançados em Banco de Dados'),
select idProva from prova where idUcr = 1;

-- Notas do Aluno 1
select * from nota where idAluno = 1 AND idProva in (select idProva from prova where idUcr = 1);

-- Notas do Aluno 1 com peso
select nota.*,peso,(valor*peso) as notaPeso from nota 
inner join prova using(idProva)
where idAluno = 1 AND idProva in (select idProva from prova where idUcr = 1);

-- Soma notaPeso e peso
-- Notas do Aluno 1 com peso na Ucr 1
select sum(peso) as sPeso ,sum(valor*peso) as sNotaPeso, sum(valor*peso)/sum(peso) as médiaPonderada from nota 
inner join prova using(idProva)
where idAluno = 1 AND idProva in (select idProva from prova where idUcr = 1);


-- IDs das provas da UCr 2
-- (2,'Introdução à Programação Web'),
select idProva from prova where idUcr = 2;

-- Notas do Aluno 1
select * from nota where idAluno = 1 AND idProva in (select idProva from prova where idUcr = 2)
union
select * from nota where idAluno = 1 AND idProva in (select idProva from prova where idUcr = 3)
union
select * from nota where idAluno = 1 AND idProva in (select idProva from prova where idUcr = 4)
union
select * from nota where idAluno = 1 AND idProva in (select idProva from prova where idUcr = 5);


-- Médias Ponderadas do Aluno 1
select ucr.nome UCR, sum(valor*peso)/sum(peso) as médiaPonderada from nota 
inner join prova using(idProva)
right join ucr using(idUcr)
where idAluno = 1 AND idProva in (select idProva from prova where idUcr = 1)
union
select ucr.nome UCR, sum(valor*peso)/sum(peso) as médiaPonderada from nota 
inner join prova using(idProva)
right join ucr using(idUcr)
where idAluno = 1 AND idProva in (select idProva from prova where idUcr = 2)
union
select ucr.nome UCR, sum(valor*peso)/sum(peso) as médiaPonderada from nota 
inner join prova using(idProva)
right join ucr using(idUcr)
where idAluno = 1 AND idProva in (select idProva from prova where idUcr = 3)
union 
select ucr.nome UCR, sum(valor*peso)/sum(peso) as médiaPonderada from nota 
inner join prova using(idProva)
right join ucr using(idUcr)
where idAluno = 1 AND idProva in (select idProva from prova where idUcr = 4)
union
select ucr.nome UCR, sum(valor*peso)/sum(peso) as médiaPonderada from nota 
inner join prova using(idProva)
right join ucr using(idUcr)
where idAluno = 1 AND idProva in (select idProva from prova where idUcr = 5);






