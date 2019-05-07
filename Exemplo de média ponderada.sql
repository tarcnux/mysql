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
	id int primary key auto_increment,
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

create table prova(
	id int primary key auto_increment,
    data_realização date,
    descrição text,
    peso real
);

insert into prova values
(1, '2019-05-07', 'teste 1', 0.6),
(2, '2019-05-10', 'teste 2', 0.2),
(3, '2019-05-14', 'teste 3', 0.2);

create table nota(
	aluno_id int,
    prova_id int,
    valor real,
    primary key(aluno_id,prova_id),
    foreign key(aluno_id) references aluno(id),
    foreign key(prova_id) references prova(id)
);

insert into nota values
(1,1,8.8),
(1,2,7.7),
(1,3,9.9),
(2,1,10),
(2,2,10),
(2,3,10),
(3,1,5.6),
(3,2,6.5),
(3,3,4.3);


select nome, prova.id as prova, prova.peso, valor, prova.peso*valor as valor_real from nota
inner join aluno on aluno_id = aluno.id
inner join prova on prova_id = prova.id order by nome;

select nome, 
round(sum(prova.peso*valor),2) as soma, 
round(sum(prova.peso),2) as soma_peso,
round(sum(prova.peso*valor)/sum(prova.peso),2) as média 
from nota
inner join aluno on aluno_id = aluno.id
inner join prova on prova_id = prova.id
group by nome order by aluno.id;





