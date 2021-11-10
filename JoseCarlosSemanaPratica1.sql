CREATE TABLE instrutor(
	id_instrutor serial NOT NULL PRIMARY KEY,
	rg_instrutor varchar(7),
	nome varchar(45),
	nascimento_instrutor date,
	titulacao_instrutor int
);

CREATE TABLE atividade(
	id_atividade serial NOT NULL PRIMARY KEY,
	nome varchar(100)
);

CREATE TABLE aluno(
	cod_matricula int not null primary key,
	turma_idturma int,
	data_matricula date,
	nome varchar(45),
	endereco text,
	telefone int,
	dataNascimento date,
	altura float,
	peso int,
	check ((altura<=2.5)and(altura>=0)and(peso>=0)and(peso<=400))
);

CREATE TABLE turma(
	id_turma serial NOT NULL PRIMARY KEY,
	horario TIMESTAMPTZ,
	duracao int,
	data_inicio date,
	data_fim date,
	atividade_idatividade int,
	instrutor_idinstrutor int,
	CONSTRAINT fk_atividade_idatividade FOREIGN KEY (atividade_idatividade) 
	REFERENCES atividade(id_atividade) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_instrutor_idinstrutor FOREIGN KEY (instrutor_idinstrutor) 
	REFERENCES instrutor(id_instrutor) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE telefone_instrutor(
	id_telefone serial NOT NULL PRIMARY KEY,
	numero int,
	tipo varchar(45),
	instrutor_idinstrutor int,
	CONSTRAINT fk_instrutor_idinstrutor FOREIGN KEY (instrutor_idinstrutor) 
	REFERENCES instrutor(id_instrutor) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE matricula(
	aluno_codMatricula int,
	turma_idTurma int,
	CONSTRAINT pk_matricula PRIMARY KEY(aluno_codMatricula,turma_idTurma),
	CONSTRAINT fk_aluno_codMatricula FOREIGN KEY (aluno_codMatricula) 
	REFERENCES aluno(cod_matricula) ON DELETE RESTRICT ON UPDATE CASCADE,
	CONSTRAINT fk_turma_idTurma FOREIGN KEY (turma_idTurma) 
	REFERENCES turma(id_turma) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE chamada(
    id_chamada serial not null primary key,
    data_chamada Date,
    presente BOOL,
    matricula_aluno_codMatricula INT,
    matricula_turma_idturma INT,
	CONSTRAINT fk_matricula_aluno_turma FOREIGN KEY (matricula_aluno_codMatricula, matricula_turma_idturma) 
	REFERENCES matricula(aluno_codMatricula, turma_idTurma) ON DELETE RESTRICT ON UPDATE CASCADE
);


create user Diretor with password 'diretor123'; 

grant insert, update, delete, 
select on instrutor, telefone_instrutor, aluno, turma, atividade, matricula, chamada
to Diretor;

create user Instrutor with password 'instrutor321';

grant insert, update, delete, 
select on chamada 
to Instrutor;

create user Aluno with password 'aluno312';

grant select
on chamada 
to Aluno;