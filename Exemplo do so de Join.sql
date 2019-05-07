#Exemplo do so de joins
#http://www.mysqltutorial.org/mysql-join/

create table t1(
	id int primary key,
	cor varchar(20)
);

create table t2(
	id varchar(20) primary key,
    cor varchar(20)
);

insert into t1(id, cor)
values	(1,"Amarelo"),
		(2,"Vermelho"),
        (3,"Azul");
insert into t2(id,cor)
values	("Vo","Vermelho"),
		("Ve","Verde"),
        ("Az","Azul");

select t1.id,t2.id 
from t1 
cross join t2;

select t1.id,t2.id 
from t1 
inner join t2 
on t1.cor = t2.cor;


select t1.id,t2.id 
from t1 
inner join t2 
using(cor);

select t1.id,t2.id,t1.cor 
from t1 
left join t2 
on t1.cor = t2.cor 
order by t1.id;

create view direita as
select t1.id as idT1,t2.id as idT2,t2.cor 
from t1 
right join t2 
on t1.cor = t2.cor 
order by t1.id;

select * from direita;
show tables;