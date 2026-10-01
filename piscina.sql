-- Base de Dados: Gestao de Piscina Municipal
-- Curso: Tecnico de Desenvolvimento de Software | UC 02830
-- Grupo 5: Ana Marques, Jean Xavier, Hugo Teixeira

DROP DATABASE IF EXISTS piscina_municipal;
CREATE DATABASE piscina_municipal;
USE piscina_municipal;

--  cargo 
CREATE TABLE cargo (
id_cargo INT  PRIMARY KEY,
designacao VARCHAR(50)
);


 -- funcionario  

CREATE TABLE funcionario (
 num_funcionario INT  PRIMARY KEY,
 nome VARCHAR(100),
 nif CHAR(9),
 telemovel VARCHAR(15),
 id_cargo INT,
 data_admissao DATE,
 FOREIGN KEY (id_cargo) REFERENCES cargo(id_cargo)
 );

-- monitor  

CREATE TABLE monitor (
    num_monitor INT PRIMARY KEY,
    nome VARCHAR(100),
    especialidade VARCHAR(60),
    telemovel VARCHAR(15)
);


-- contrato_trabalho 

CREATE TABLE contrato_trabalho (
 id_contrato INT  PRIMARY KEY,
 num_monitor INT,
 data_inicio DATE,
 salario_base DECIMAL(7,2),
 FOREIGN KEY (num_monitor) REFERENCES monitor(num_monitor)
);


--  utente 

CREATE TABLE utente (
  num_utente INT PRIMARY KEY,
  nome VARCHAR(100),
  data_nascimento DATE,
  telemovel VARCHAR(15),
  email  VARCHAR(100)
);


--  ficha_medica  

CREATE TABLE ficha_medica (
    id_ficha  INT PRIMARY KEY,
    num_utente INT,
    data_exame DATE,
    resultado ENUM("Apto","Inapto"),
    FOREIGN KEY (num_utente) REFERENCES utente(num_utente)
);


-- pista  

CREATE TABLE pista (
    num_pista  INT PRIMARY KEY,
    profundidade DECIMAL(3,2),
    tipo_pista ENUM("Competicao","Criancas","Lazer")
);


--  servico  

CREATE TABLE servico (
  id_servico INT PRIMARY KEY,
  nome_servico VARCHAR(60),
  mensalidade DECIMAL(6,2),
  descricao VARCHAR(200)
);


-- aula  

CREATE TABLE aula (
  id_aula  INT PRIMARY KEY,
  id_servico INT,
  num_monitor INT,
  num_pista INT,
  horario  DATETIME,
  capacidade_max INT,
  FOREIGN KEY (id_servico) REFERENCES servico(id_servico),
  FOREIGN KEY (num_monitor) REFERENCES monitor(num_monitor),
  FOREIGN KEY (num_pista) REFERENCES pista(num_pista)
);


-- inscricao_aula  

CREATE TABLE inscricao_aula (
  id_inscricao INT PRIMARY KEY,
  num_utente INT,
  id_aula INT,
  data_inscricao DATE,
  presente TINYINT NOT NULL DEFAULT 0,
  FOREIGN KEY (num_utente) REFERENCES utente(num_utente),
  FOREIGN KEY (id_aula) REFERENCES aula(id_aula),
  UNIQUE (num_utente, id_aula)
);


-- utilizacao_livre  

CREATE TABLE utilizacao_livre (
  id_utilizacao INT PRIMARY KEY,
  num_utente INT,
  num_pista INT,
  hora_entrada DATETIME,
  hora_saida  DATETIME,
  FOREIGN KEY (num_utente) REFERENCES utente(num_utente),
  FOREIGN KEY (num_pista) REFERENCES pista(num_pista)
);


-- pagamento  

CREATE TABLE pagamento (
  id_pagamento INT PRIMARY KEY,
  num_utente INT,
  id_servico INT,
  data_pagamento DATE,
  valor_pago DECIMAL(6,2),
  pago TINYINT NOT NULL DEFAULT 1, -- 1 = pago, 0 = por pagar
  FOREIGN KEY (num_utente) REFERENCES utente(num_utente),
  FOREIGN KEY (id_servico) REFERENCES servico(id_servico)
);


-- avaliacao  

CREATE TABLE avaliacao (
  id_avaliacao  INT PRIMARY KEY,
  num_utente INT,
  id_aula INT,
  nota VARCHAR(30),       -- nota de 1 (fraca) a 5 (excelente)
  comentario VARCHAR(200),
  data_avaliacao DATE,
  FOREIGN KEY (num_utente) REFERENCES utente(num_utente),
  FOREIGN KEY (id_aula) REFERENCES aula(id_aula)
);

--  manutencao_pista

CREATE TABLE manutencao_pista (
  id_manutencao INT PRIMARY KEY,
  num_pista  INT NOT NULL,
  num_funcionario  INT NOT NULL,
  data_manutencao  DATE NOT NULL,
  descricao  VARCHAR(200) NOT NULL,
  custo  DECIMAL(7,2) NOT NULL,
  FOREIGN KEY (num_pista) REFERENCES pista(num_pista),
  FOREIGN KEY (num_funcionario) REFERENCES funcionario(num_funcionario)
);


-- lista_espera  

CREATE TABLE lista_espera (
  id_lista  INT PRIMARY KEY,
  num_utente INT NOT NULL,
  id_aula INT NOT NULL,
  data_pedido DATE NOT NULL,
  posicao INT NOT NULL,
  FOREIGN KEY (num_utente) REFERENCES utente(num_utente),
  FOREIGN KEY (id_aula) REFERENCES aula(id_aula),
  UNIQUE (num_utente, id_aula)
);


-- equipamento  

CREATE TABLE equipamento (
  id_equipamento INT PRIMARY KEY,
  nome  VARCHAR(60) NOT NULL,
  quantidade INT NOT NULL,
  estado  ENUM("Bom","Razoavel","Mau") NOT NULL,
  num_pista INT NOT NULL,
  FOREIGN KEY (num_pista) REFERENCES pista(num_pista)
);

-- INSERCAO DE DADOS -- 

INSERT INTO cargo (id_cargo, designacao) VALUE (1, "Rececionista");
INSERT INTO cargo (id_cargo, designacao) VALUE (2, "Nadador-Salvador");
INSERT INTO cargo (id_cargo, designacao) VALUE (3, "Tecnico de Manutencao");
INSERT INTO cargo (id_cargo, designacao) VALUE (4, "Coordenador Desportivo");

INSERT INTO funcionario (num_funcionario, nome, nif, telemovel, id_cargo, data_admissao) VALUE (1, "Rui Santos", "198234567", "912345001", 1, "2019-03-01");
INSERT INTO funcionario (num_funcionario, nome, nif, telemovel, id_cargo, data_admissao) VALUE (2, "Marta Alves", "234567891", "912345002", 2, "2020-06-15");
INSERT INTO funcionario (num_funcionario, nome, nif, telemovel, id_cargo, data_admissao) VALUE (3, "Bruno Costa", "256789012", "912345003", 2, "2021-01-10");
INSERT INTO funcionario (num_funcionario, nome, nif, telemovel, id_cargo, data_admissao) VALUE (4, "Sofia Rocha", "267891234", "912345004", 3, "2018-09-20");
INSERT INTO funcionario (num_funcionario, nome, nif, telemovel, id_cargo, data_admissao) VALUE (5, "Tiago Nunes", "278912345", "912345005", 3, "2022-02-05");
INSERT INTO funcionario (num_funcionario, nome, nif, telemovel, id_cargo, data_admissao) VALUE (6, "Helena Pinto", "289123456", "912345006", 4, "2017-05-12");

INSERT INTO monitor (num_monitor, nome, especialidade, telemovel) VALUE (1, "Carla Mendes", "Natacao Infantil", "913000001");
INSERT INTO monitor (num_monitor, nome, especialidade, telemovel) VALUE (2, "Joao Ferreira", "Hidroginastica", "913000002");
INSERT INTO monitor (num_monitor, nome, especialidade, telemovel) VALUE (3, "Ines Batista", "Natacao Adultos", "913000003");
INSERT INTO monitor (num_monitor, nome, especialidade, telemovel) VALUE (4, "Pedro Lopes", "Aqua Fitness", "913000004");
INSERT INTO monitor (num_monitor, nome, especialidade, telemovel) VALUE (5, "Ana Cordeiro", "Natacao Senior", "913000005");

INSERT INTO contrato_trabalho (id_contrato, num_monitor, data_inicio, salario_base) VALUE (1, 1, "2019-09-01", 1050.0);
INSERT INTO contrato_trabalho (id_contrato, num_monitor, data_inicio, salario_base) VALUE (2, 2, "2018-02-15", 1200.0);
INSERT INTO contrato_trabalho (id_contrato, num_monitor, data_inicio, salario_base) VALUE (3, 3, "2020-10-01", 1100.0);
INSERT INTO contrato_trabalho (id_contrato, num_monitor, data_inicio, salario_base) VALUE (4, 4, "2021-06-01", 1080.0);
INSERT INTO contrato_trabalho (id_contrato, num_monitor, data_inicio, salario_base) VALUE (5, 5, "2017-03-10", 1150.0);


INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (1, "Miguel Sousa", "2016-04-12", "921000001", "miguel.sousa@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (2, "Beatriz Ramos", "2015-08-23", "921000002", "beatriz.ramos@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (3, "Diogo Fonseca", "1990-01-15", "921000003", "diogo.fonseca@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (4, "Catarina Neves", "1988-11-02", "921000004", "catarina.neves@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (5, "Rafael Teixeira", "1995-03-30", "921000005", "rafael.teixeira@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (6, "Leonor Vieira", "1958-07-19", "921000006", "leonor.vieira@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (7, "Antonio Marques", "1952-12-05", "921000007", "antonio.marques@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (8, "Sara Antunes", "2017-02-18", "921000008", "sara.antunes@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (9, "Vasco Pereira", "1983-09-09", "921000009", "vasco.pereira@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (10, "Ines Correia", "1960-05-27", "921000010", "ines.correia@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (11, "Joana Cardoso", "2014-10-11", "921000011", "joana.cardoso@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (12, "Filipe Baptista", "1975-06-08", "921000012", "filipe.baptista@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (13, "Marisa Coelho", "1998-01-25", "921000013", "marisa.coelho@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (14, "Nuno Barros", "1955-03-14", "921000014", "nuno.barros@mail.com");
INSERT INTO utente (num_utente, nome, data_nascimento, telemovel, email) VALUE (15, "Rita Moreira", "2018-07-02", "921000015", "rita.moreira@mail.com");

INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (1, 1, "2026-01-10", "Apto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (2, 2, "2026-01-10", "Apto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (3, 3, "2026-02-05", "Apto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (4, 4, "2026-02-05", "Apto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (5, 5, "2026-02-20", "Apto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (6, 6, "2026-03-01", "Apto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (7, 7, "2026-03-01", "Inapto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (8, 8, "2026-03-15", "Apto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (9, 9, "2026-04-02", "Apto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (10, 10, "2026-04-02", "Apto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (11, 11, "2026-04-18", "Apto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (12, 12, "2026-05-01", "Apto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (13, 13, "2026-05-10", "Apto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (14, 14, "2026-05-10", "Inapto");
INSERT INTO ficha_medica (id_ficha, num_utente, data_exame, resultado) VALUE (15, 15, "2026-06-01", "Apto");

INSERT INTO pista (num_pista, profundidade, tipo_pista) VALUE (1, 2.0, "Competicao");
INSERT INTO pista (num_pista, profundidade, tipo_pista) VALUE (2, 0.9, "Criancas");
INSERT INTO pista (num_pista, profundidade, tipo_pista) VALUE (3, 1.6, "Lazer");

INSERT INTO servico (id_servico, nome_servico, mensalidade, descricao) VALUE (1, "Natacao Infantil", 35.0, "Aulas de adaptacao ao meio aquatico para criancas");
INSERT INTO servico (id_servico, nome_servico, mensalidade, descricao) VALUE (2, "Hidroginastica", 40.0, "Exercicio aquatico de baixo impacto");
INSERT INTO servico (id_servico, nome_servico, mensalidade, descricao) VALUE (3, "Natacao Adultos", 38.0, "Aperfeicoamento tecnico de natacao para adultos");
INSERT INTO servico (id_servico, nome_servico, mensalidade, descricao) VALUE (4, "Aqua Fitness", 42.0, "Treino cardiovascular em meio aquatico");
INSERT INTO servico (id_servico, nome_servico, mensalidade, descricao) VALUE (5, "Natacao Senior", 30.0, "Atividade aquatica adaptada a seniores");

INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (1, 1, 1, 2, "2026-09-07 10:00:00", 3);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (2, 1, 1, 2, "2026-09-09 10:00:00", 10);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (3, 2, 2, 1, "2026-09-07 18:00:00", 15);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (4, 2, 2, 3, "2026-09-08 18:00:00", 15);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (5, 2, 2, 1, "2026-09-10 18:00:00", 15);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (6, 3, 3, 1, "2026-09-07 20:00:00", 12);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (7, 3, 3, 1, "2026-09-09 20:00:00", 12);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (8, 4, 4, 3, "2026-09-08 19:00:00", 14);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (9, 4, 4, 3, "2026-09-10 19:00:00", 14);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (10, 5, 5, 2, "2026-09-07 09:00:00", 8);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (11, 5, 5, 2, "2026-09-09 09:00:00", 8);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (12, 3, 3, 1, "2026-09-11 20:00:00", 12);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (13, 4, 4, 3, "2026-09-12 19:00:00", 14);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (14, 2, 2, 1, "2026-09-12 18:00:00", 15);
INSERT INTO aula (id_aula, id_servico, num_monitor, num_pista, horario, capacidade_max) VALUE (15, 5, 5, 2, "2026-09-11 09:00:00", 8);

INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (1, 1, 1, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (2, 1, 2, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (3, 8, 1, "2026-09-01", 0);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (4, 8, 2, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (5, 11, 1, "2026-09-02", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (6, 15, 2, "2026-09-02", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (7, 6, 3, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (8, 6, 4, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (9, 6, 5, "2026-09-01", 0);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (10, 10, 3, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (11, 10, 5, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (12, 14, 4, "2026-09-02", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (13, 4, 6, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (14, 4, 7, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (15, 5, 6, "2026-09-01", 0);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (16, 5, 12, "2026-09-03", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (17, 3, 7, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (18, 13, 6, "2026-09-02", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (19, 9, 8, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (20, 9, 9, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (21, 9, 13, "2026-09-04", 0);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (22, 12, 8, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (23, 12, 13, "2026-09-04", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (24, 4, 9, "2026-09-01", 0);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (25, 6, 11, "2026-09-01", 0);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (26, 3, 6, "2026-09-01", 1);
INSERT INTO inscricao_aula (id_inscricao, num_utente, id_aula, data_inscricao, presente) VALUE (27, 13, 7, "2026-09-02", 0);

INSERT INTO utilizacao_livre (id_utilizacao, num_utente, num_pista, hora_entrada, hora_saida) VALUE (1, 3, 1, "2026-09-05 07:00:00", "2026-09-05 08:00:00");
INSERT INTO utilizacao_livre (id_utilizacao, num_utente, num_pista, hora_entrada, hora_saida) VALUE (2, 9, 3, "2026-09-05 17:00:00", "2026-09-05 18:00:00");
INSERT INTO utilizacao_livre (id_utilizacao, num_utente, num_pista, hora_entrada, hora_saida) VALUE (3, 12, 1, "2026-09-06 07:30:00", "2026-09-06 08:15:00");
INSERT INTO utilizacao_livre (id_utilizacao, num_utente, num_pista, hora_entrada, hora_saida) VALUE (4, 4, 3, "2026-09-06 18:00:00", "2026-09-06 19:00:00");
INSERT INTO utilizacao_livre (id_utilizacao, num_utente, num_pista, hora_entrada, hora_saida) VALUE (5, 5, 1, "2026-09-08 07:00:00", "2026-09-08 07:45:00");
INSERT INTO utilizacao_livre (id_utilizacao, num_utente, num_pista, hora_entrada, hora_saida) VALUE (6, 13, 3, "2026-09-08 18:30:00", "2026-09-08 19:20:00");
INSERT INTO utilizacao_livre (id_utilizacao, num_utente, num_pista, hora_entrada, hora_saida) VALUE (7, 3, 1, "2026-09-10 07:00:00", "2026-09-10 08:00:00");
INSERT INTO utilizacao_livre (id_utilizacao, num_utente, num_pista, hora_entrada, hora_saida) VALUE (8, 9, 3, "2026-09-11 17:15:00", "2026-09-11 18:00:00");

INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (1, 1, 1, "2026-09-01", 35.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (2, 8, 1, "2026-09-01", 35.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (3, 11, 1, "2026-09-02", 35.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (4, 15, 1, "2026-09-02", 35.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (5, 6, 2, "2026-09-01", 40.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (6, 10, 2, "2026-09-01", 40.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (7, 14, 2, "2026-09-02", 40.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (8, 4, 3, "2026-09-01", 38.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (9, 5, 3, "2026-09-01", 38.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (10, 3, 3, "2026-09-01", 38.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (11, 13, 3, "2026-09-02", 38.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (12, 9, 4, "2026-09-01", 42.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (13, 12, 4, "2026-09-01", 42.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (14, 7, 5, "2026-09-01", 30.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (15, 14, 5, "2026-09-01", 30.0, 1);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (16, 4, 3, "2026-09-01", 38.0, 0);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (17, 5, 3, "2026-08-31", 38.0, 0);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (18, 5, 3, "2026-09-30", 38.0, 0);
INSERT INTO pagamento (id_pagamento, num_utente, id_servico, data_pagamento, valor_pago, pago) VALUE (19, 9, 4, "2026-09-30", 38.0, 0);

INSERT INTO avaliacao (id_avaliacao, num_utente, id_aula, nota, comentario, data_avaliacao) VALUE (1, 1, 1, 5, "Excelente monitora, muito paciente com as criancas", "2026-09-07");
INSERT INTO avaliacao (id_avaliacao, num_utente, id_aula, nota, comentario, data_avaliacao) VALUE (2, 8, 2, 4, "Gostei bastante da aula", "2026-09-09");
INSERT INTO avaliacao (id_avaliacao, num_utente, id_aula, nota, comentario, data_avaliacao) VALUE (3, 6, 3, 5, "Aula muito dinamica", "2026-09-07");
INSERT INTO avaliacao (id_avaliacao, num_utente, id_aula, nota, comentario, data_avaliacao) VALUE (4, 10, 5, 4, "Bom ritmo de exercicio", "2026-09-10");
INSERT INTO avaliacao (id_avaliacao, num_utente, id_aula, nota, comentario, data_avaliacao) VALUE (5, 4, 6, 3, "Podia ser mais tecnica", "2026-09-07");
INSERT INTO avaliacao (id_avaliacao, num_utente, id_aula, nota, comentario, data_avaliacao) VALUE (6, 9, 8, 5, "Otimo treino cardiovascular", "2026-09-08");
INSERT INTO avaliacao (id_avaliacao, num_utente, id_aula, nota, comentario, data_avaliacao) VALUE (7, 7, 10, 5, "Ambiente calmo, adequado a idade", "2026-09-07");
INSERT INTO avaliacao (id_avaliacao, num_utente, id_aula, nota, comentario, data_avaliacao) VALUE (8, 12, 8, 4, "Recomendo", "2026-09-08");
INSERT INTO avaliacao (id_avaliacao, num_utente, id_aula, nota, comentario, data_avaliacao) VALUE (9, 3, 7, 4, "Boa evolucao tecnica", "2026-09-09");
INSERT INTO avaliacao (id_avaliacao, num_utente, id_aula, nota, comentario, data_avaliacao) VALUE (10, 13, 6, 3, "Turma um pouco cheia", "2026-09-07");

INSERT INTO manutencao_pista (id_manutencao, num_pista, num_funcionario, data_manutencao, descricao, custo) VALUE (1, 1, 4, "2026-08-15", "Verificacao do sistema de filtragem", 120.0);
INSERT INTO manutencao_pista (id_manutencao, num_pista, num_funcionario, data_manutencao, descricao, custo) VALUE (2, 2, 5, "2026-08-20", "Limpeza profunda e tratamento quimico", 80.0);
INSERT INTO manutencao_pista (id_manutencao, num_pista, num_funcionario, data_manutencao, descricao, custo) VALUE (3, 3, 4, "2026-08-22", "Reparacao de azulejos danificados", 250.0);
INSERT INTO manutencao_pista (id_manutencao, num_pista, num_funcionario, data_manutencao, descricao, custo) VALUE (4, 1, 5, "2026-09-01", "Substituicao de bomba de recirculacao", 430.0);
INSERT INTO manutencao_pista (id_manutencao, num_pista, num_funcionario, data_manutencao, descricao, custo) VALUE (5, 3, 4, "2026-09-03", "Verificacao do nivel de cloro", 40.0);
INSERT INTO manutencao_pista (id_manutencao, num_pista, num_funcionario, data_manutencao, descricao, custo) VALUE (6, 2, 5, "2026-09-05", "Manutencao preventiva mensal", 60.0);

INSERT INTO lista_espera (id_lista, num_utente, id_aula, data_pedido, posicao) VALUE (1, 2, 1, "2026-09-03", 1);
INSERT INTO lista_espera (id_lista, num_utente, id_aula, data_pedido, posicao) VALUE (2, 15, 1, "2026-09-04", 2);

INSERT INTO equipamento (id_equipamento, nome, quantidade, estado, num_pista) VALUE (1, "Boias de natacao", 20, "Bom", 2);
INSERT INTO equipamento (id_equipamento, nome, quantidade, estado, num_pista) VALUE (2, "Coletes salva-vidas", 15, "Bom", 2);
INSERT INTO equipamento (id_equipamento, nome, quantidade, estado, num_pista) VALUE (3, "Blocos de partida", 4, "Bom", 1);
INSERT INTO equipamento (id_equipamento, nome, quantidade, estado, num_pista) VALUE (4, "Colchoes flutuantes", 10, "Razoavel", 3);
INSERT INTO equipamento (id_equipamento, nome, quantidade, estado, num_pista) VALUE (5, "Corda divisoria de pista", 6, "Bom", 1);
INSERT INTO equipamento (id_equipamento, nome, quantidade, estado, num_pista) VALUE (6, "Pranchas de natacao", 12, "Bom", 2);
  

-- Consulta 1 - Pergunta so com criterios (uma tabela)
-- "Quais os utentes com 65 ou mais anos (utentes senior)?"
SELECT nome
FROM utente
WHERE data_nascimento <= DATE_SUB(CURDATE(), INTERVAL 65 YEAR)
ORDER BY nome;

-- Consulta 2- Pergunta so com criterios (N tabelas)
-- "Quais as aulas (horario, servico, monitor) que decorrem na pista de Competicao?"
SELECT a.horario, s.nome_servico AS servico, m.nome AS monitor
FROM aula a
INNER JOIN servico s ON a.id_servico = s.id_servico
INNER JOIN monitor m ON a.num_monitor = m.num_monitor
INNER JOIN pista p ON a.num_pista = p.num_pista
WHERE p.tipo_pista = "Competicao"
ORDER BY a.horario;

-- Consulta 3 - Pergunta com Group By (Distinct)
-- "Quantos utentes distintos estao inscritos em cada servico?"
SELECT s.nome_servico, COUNT(DISTINCT ia.num_utente) AS total_utentes
FROM servico s
INNER JOIN aula a ON a.id_servico = s.id_servico
INNER JOIN inscricao_aula ia ON ia.id_aula = a.id_aula
GROUP BY s.nome_servico
ORDER BY total_utentes DESC;

-- Consulta 4 - Pergunta com Group By (com criterios)
-- "Quais os monitores que lecionam mais de 2 aulas?"
SELECT m.nome, COUNT(a.id_aula) AS total_aulas
FROM monitor m
INNER JOIN aula a ON a.num_monitor = m.num_monitor
GROUP BY m.nome
HAVING total_aulas > 2 --  A cláusula HAVING é usada para filtrar os resultados de uma consulta GROUP BY com base em funções de agregação.
ORDER BY total_aulas DESC;

-- Consulta 5 - Pergunta com NOT IN
-- "Quais os utentes que nunca se inscreveram em nenhuma aula?"
SELECT nome, telemovel
FROM utente
WHERE num_utente NOT IN (SELECT num_utente FROM inscricao_aula);

-- Consulta 6 - Pergunta com Subquery
-- "Quais as aulas cuja capacidade maxima é superior a media de capacidade de todas as aulas?"
  SELECT DISTINCT s.nome_servico AS "Serviço",
       (SELECT ROUND(AVG(capacidade_max), 1) FROM aula) AS "Capacidade media",  a.capacidade_max AS "capacidade maxima"
FROM aula a
JOIN servico s ON s.id_servico = a.id_servico
WHERE a.capacidade_max > (SELECT AVG(capacidade_max) FROM aula)
ORDER BY a.capacidade_max DESC;

-- Consulta 7 - Pergunta com calculo de maximo/minimo
-- "Qual a mensalidade mais cara e mais barata entre os servicos disponiveis?"
SELECT MAX(mensalidade) AS mensalidade_maxima, MIN(mensalidade) AS mensalidade_minima
FROM servico;

-- Consulta 8 - Pergunta com UNION
-- "Lista de contactos (nome, telemovel, tipo) de todos os Utentes e Monitores"
SELECT nome, telemovel, "Utente" AS tipo FROM utente
UNION ALL
SELECT nome, telemovel, "Monitor" AS tipo FROM monitor
ORDER BY tipo, nome;

-- Consulta 9 - Pergunta com IF
-- "Para cada aula, esta 'Lotada' ou 'Com vagas'?"
SELECT a.id_aula, s.nome_servico, a.capacidade_max,
       COUNT(ia.id_inscricao) AS total_inscritos,
       IF(COUNT(ia.id_inscricao) >= a.capacidade_max, "Lotada", "Com vagas") AS estado
FROM aula a
JOIN servico s ON a.id_servico = s.id_servico
LEFT JOIN inscricao_aula ia ON ia.id_aula = a.id_aula
GROUP BY a.id_aula, s.nome_servico, a.capacidade_max
ORDER BY a.id_aula;

-- Consulta 10 - Pergunta com subquery + calculo
-- "Qual a taxa de assiduidade (%) de cada utente inscrito em pelo menos uma aula?"
SELECT u.num_utente, u.nome,
COUNT(*) AS total_inscricoes,
SUM(ia.presente) AS total_presencas,
ROUND(AVG(ia.presente) * 100, 1) AS taxa_assiduidade_pct
FROM utente u
JOIN inscricao_aula ia ON ia.num_utente = u.num_utente
GROUP BY u.num_utente, u.nome
ORDER BY taxa_assiduidade_pct DESC;

-- Consulta 11 (extra) - Aulas sem nenhum utente inscrito
SELECT a.id_aula, s.nome_servico, a.horario
FROM aula a
JOIN servico s ON a.id_servico = s.id_servico
LEFT JOIN inscricao_aula ia ON ia.id_aula = a.id_aula
WHERE ia.id_inscricao IS NULL;

-- Consulta 12 (extra) - Monitor com mais aulas lecionadas 
SELECT m.nome, COUNT(a.id_aula) AS total_aulas
FROM monitor m
JOIN aula a ON a.num_monitor = m.num_monitor
GROUP BY m.nome
ORDER BY total_aulas DESC
LIMIT 1;

-- Consulta 13 (extra) - Numero de utentes em lista de espera por aula lotada
SELECT a.id_aula, s.nome_servico, COUNT(le.id_lista) AS utente_lista_espera
FROM aula a
JOIN servico s ON a.id_servico = s.id_servico
JOIN lista_espera le ON le.id_aula = a.id_aula
GROUP BY s.nome_servico, a.id_aula
ORDER BY utente_lista_espera DESC;

-- Consulta 14 (extra) - Utentes que ainda devem e quantas mensalidades devem
SELECT u.num_utente, u.nome,
COUNT(*) AS mensalidades_em_divida,
SUM(p.valor_pago) AS total_em_divida
FROM pagamento p
JOIN utente u ON u.num_utente = p.num_utente
WHERE p.pago = 0
GROUP BY u.num_utente, u.nome
ORDER BY mensalidades_em_divida DESC, u.nome;



USE piscina_municipal;

SELECT * FROM cargo;
SELECT * FROM funcionario;
SELECT * FROM monitor;
SELECT * FROM contrato_trabalho;
SELECT * FROM utente;
SELECT * FROM ficha_medica;
SELECT * FROM pista;
SELECT * FROM servico;
SELECT * FROM aula;
SELECT * FROM inscricao_aula;
SELECT * FROM utilizacao_livre;
SELECT * FROM pagamento;
SELECT * FROM avaliacao;
SELECT * FROM manutencao_pista;
SELECT * FROM lista_espera;
SELECT * FROM equipamento;

