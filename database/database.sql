/*
    Olá Professor Milton, nós acatamos os comentários adicionados na entrega passada, 
    o numero_telefone do funcionario foi alterado para ter 13 caracteres ao invés de 30, decidimos não criar uma  nova tabela
    porque esse número não terá muitos ddd's diferentes devido as nossas intenções iniciais de atingir empresas paulistas.
    O outro comentário de que a mesma pergunta pode ser feita em atendimentos diferentes e por isso seria N - N, mas cada pergunta possui
    um tempo de reconhecimento específico e os sinais também, o que nos leva a pensar que cada pergunta feita deve ter seus próprios sinais
    e um tempo específico, espero que entenda.
*/

/* DDL */

DROP TABLE TB_FUNCIONARIO CASCADE CONSTRAINTS;
DROP TABLE TB_ATENDIMENTO CASCADE CONSTRAINTS;
DROP TABLE TB_PERGUNTA CASCADE CONSTRAINTS;
DROP TABLE TB_SINAL CASCADE CONSTRAINTS;
DROP TABLE TB_RESPOSTA CASCADE CONSTRAINTS;

CREATE TABLE TB_FUNCIONARIO (
    ID_FUNCIONARIO INTEGER NOT NULL,
    NOME_COMPLETO VARCHAR(80) NOT NULL,
    EMAIL VARCHAR(50) NOT NULL,
    SENHA VARCHAR(30) NOT NULL,
    DATA_CADASTRO TIMESTAMP NOT NULL,
    NUMERO_TELEFONE VARCHAR(13),
    PRIMARY KEY (ID_FUNCIONARIO)
);

CREATE TABLE TB_ATENDIMENTO (
    ID_ATENDIMENTO INTEGER NOT NULL,
    ID_FUNCIONARIO INTEGER NOT NULL,
    DURACAO_MINUTOS INTEGER,
    ASSUNTO VARCHAR(30),
    DATA TIMESTAMP NOT NULL,
    PRIMARY KEY (ID_ATENDIMENTO),
    FOREIGN KEY (ID_FUNCIONARIO) REFERENCES TB_FUNCIONARIO(ID_FUNCIONARIO)
);

CREATE TABLE TB_PERGUNTA (
    ID_PERGUNTA INTEGER NOT NULL,
    ID_ATENDIMENTO INTEGER NOT NULL,
    TEXTO VARCHAR(100) NOT NULL,
    DURACAO_SEGUNDOS INTEGER,
    PRIMARY KEY (ID_PERGUNTA),
    FOREIGN KEY (ID_ATENDIMENTO) REFERENCES TB_ATENDIMENTO(ID_ATENDIMENTO)
);

CREATE TABLE TB_SINAL (
    ID_SINAL INTEGER NOT NULL,
    ID_PERGUNTA INTEGER NOT NULL,
    TEXTO VARCHAR(50) NOT NULL,
    TEMPO_RECONHECIMENTO_SEGUNDOS INTEGER NOT NULL,
    PRIMARY KEY (ID_SINAL),
    FOREIGN KEY (ID_PERGUNTA) REFERENCES TB_PERGUNTA(ID_PERGUNTA)
);

CREATE TABLE TB_RESPOSTA (
    ID_RESPOSTA INTEGER NOT NULL,
    ID_PERGUNTA INTEGER NOT NULL,
    TEXTO VARCHAR(100) NOT NULL,
    DURACAO_SEGUNDOS INTEGER,
    PRIMARY KEY (ID_RESPOSTA),
    FOREIGN KEY (ID_PERGUNTA) REFERENCES TB_PERGUNTA(ID_PERGUNTA)
);

/* DML */

/* 
Como a criação da base será feita de maneira natural com a utilização dos funcionários das empresas,
estarei criando dados exemplo
*/

/* Inserindo um funcionário, e um atendimento com suas tabelas filhas */

INSERT INTO TB_FUNCIONARIO VALUES (
    1,
    'Paulo Sérgio Guedes Porfírio',
    'paulogued.pf@gmail.com',
    'recognitionProgram1',
    TIMESTAMP '2021-05-05 13:00:00',
    '5511948896461'
);

INSERT INTO TB_ATENDIMENTO VALUES (
    1,
    1,
    5,
    'Falar com gerente da empresa',
    TIMESTAMP '2021-05-05 18:00:00'
);

INSERT INTO TB_PERGUNTA VALUES (
    1,
    1,
    'Quem é o gerente?',
    26
);

INSERT INTO TB_SINAL VALUES (
    1,
    1,
    'quem',
    8
);

INSERT INTO TB_SINAL VALUES (
    2,
    1,
    'é',
    5
);

INSERT INTO TB_SINAL VALUES (
    3,
    1,
    'o',
    5
);

INSERT INTO TB_SINAL VALUES (
    4,
    1,
    'gerente',
    8
);

INSERT INTO TB_RESPOSTA VALUES (
    1,
    1,
    'Daniel Guedes',
    15
);

INSERT INTO TB_PERGUNTA VALUES (
    2,
    1,
    'Onde ele está?',
    23
);

INSERT INTO TB_SINAL VALUES (
    5,
    2,
    'onde',
    7
);

INSERT INTO TB_SINAL VALUES (
    6,
    2,
    'ele',
    8
);

INSERT INTO TB_SINAL VALUES (
    7,
    2,
    'está',
    8
);

INSERT INTO TB_RESPOSTA VALUES (
    2,
    2,
    '2º andar, sala 15',
    20
);

/* DQL */

/* Mostrando tabelas criadas */

SELECT * FROM TB_FUNCIONARIO;
SELECT * FROM TB_ATENDIMENTO;
SELECT * FROM TB_PERGUNTA;
SELECT * FROM TB_SINAL;
SELECT * FROM TB_RESPOSTA;

/* Selecionando a resposta de uma pergunta feita pelo cliente */
SELECT TB_PERGUNTA.TEXTO, TB_RESPOSTA.TEXTO
FROM TB_PERGUNTA
INNER JOIN TB_RESPOSTA
ON TB_PERGUNTA.ID_PERGUNTA = TB_RESPOSTA.ID_PERGUNTA;

/* Encontrar quantidade de sinais reconhecidos em menos de 7 segundos */

SELECT COUNT(ID_SINAL), TEMPO_RECONHECIMENTO_SEGUNDOS
FROM TB_SINAL
WHERE TEMPO_RECONHECIMENTO_SEGUNDOS < 7
GROUP BY TEMPO_RECONHECIMENTO_SEGUNDOS;

/* Encontrar quantidade de repostas com duracao menor que 20 segundos */

SELECT COUNT(ID_RESPOSTA), DURACAO_SEGUNDOS
FROM TB_RESPOSTA
WHERE DURACAO_SEGUNDOS < 20
GROUP BY DURACAO_SEGUNDOS;

/* Selecionar Texto Das Perguntas */

SELECT TEXTO FROM TB_PERGUNTA;

/* Selecionar Assunto dos Atendimentos */

SELECT ASSUNTO FROM TB_ATENDIMENTO;