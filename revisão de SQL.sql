###################################
# Comentário no MySQL Workbench
# Aula de Criação e Manipulação de Banco de Dados
# 06/05/2019
#
# Revisão SQL Básico utilizando o KhanAcademy
# https://pt.khanacademy.org/computing/computer-programming/sql/
# Prof. Tarcísio Nunes (@tarcnux)
####################################

# Observação! Após cada linha de comando, para ser 
# executada, você deve pressionar Ctrl Enter

# Criando uma base de dados
create database senai;#ctrl enter
use senai;

#Apagando uma base de dados
#drop database test;#ctrl enter (PRESSIONAR)

#Criando uma tabela
#É necessário saber o nome da tabela, os nomes
#e tipos dos campos (colunas) da tabela
create table aluno(
	id int primary key auto_increment,
    nome varchar(40),
    nota1 decimal(4,2),
    nota2 decimal(4,2),
    media decimal(4,2)
);#Lembre-se de pressionar Ctrl Enter

insert into aluno(id,nome,nota1,nota2,media)
values(1,"Teobaldo Anastácio",7.8,8.5,(7.8+8.5)/2);

insert into aluno values
(2,"Cacilda Cibele",6.5,8.9,(6.5+8.9)/2),
(3,"Paulo Steffen",9,8.9,(9+8.9)/2),
(4,"Leonardo Micael",5,4,(5+4)/2);#Ctrl Enter

select * from aluno;

#Alterando uma tabela para adicionar
#uma nova coluna de e-mail

alter table aluno add column email text;
select * from aluno;
#Pequeno desafio para os pequenos gafanhotos
#Adicione um e-mail para cada aluno.
UPDATE aluno 
SET email = 'teo@baldo.com.br' 
WHERE id = 1; #PRESSINAR CTRL ENTER

UPDATE aluno 
SET email = 'cacil@da.com.br' 
WHERE id = 2; #PRESSINAR CTRL ENTER

UPDATE aluno 
SET email = 'paulo@gmáil.com.br' 
WHERE id = 3; #PRESSINAR CTRL ENTER

UPDATE aluno 
SET email = 'leo@hótmáio.com.br' 
WHERE id = 4; #PRESSINAR CTRL ENTER

SELECT * FROM ALUNO;

#Desafio!
#Corrija a nota2 4 do Leonardo para 8
UPDATE aluno 
SET nota2 = 8
WHERE id = 4; #PRESSINAR CTRL ENTER

UPDATE aluno 
SET media = (5+8)/2
WHERE id = 4; #PRESSINAR CTRL ENTER
select * from aluno;

#Alterar a tabela para remover uma coluna
alter table aluno drop column media;
select * from aluno;

#Desafio!
#Mostrar a média do aluno seguido do nome!

select round((nota1+nota2)/2,2) as Média,
nome from aluno order by Média DESC;
