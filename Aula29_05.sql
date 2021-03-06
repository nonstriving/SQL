DROP TABLE ESPECIALCUIDADO;
DROP TABLE ESPECIAL;
DROP TABLE PESSOAHABILIDADE;
DROP TABLE AULAPESSOA;
DROP SEQUENCE CONTADORESPECIAL;

CREATE TABLE AULAPESSOA(
  CPF NUMBER(11) PRIMARY KEY,
  NOME VARCHAR(50)
);

CREATE TABLE PESSOAHABILIDADE(
  CPF NUMBER(11),
  HABILIDADE VARCHAR(50),
  CONSTRAINT PKPH PRIMARY KEY (CPF,HABILIDADE),
  CONSTRAINT FKPH FOREIGN KEY (CPF) REFERENCES AULAPESSOA(CPF)
);

CREATE TABLE ESPECIAL(
  NROESPECIAL INTEGER PRIMARY KEY,
  CPFESPECIAL NUMBER(11),
  CPFSUPERVISOR NUMBER(11),
  APELIDO VARCHAR(50) DEFAULT 'NENHUM',
  CONSTRAINT FKE1 FOREIGN KEY (CPFESPECIAL) REFERENCES AULAPESSOA(CPF) ON DELETE CASCADE,
  CONSTRAINT FKE2 FOREIGN KEY (CPFSUPERVISOR) REFERENCES AULAPESSOA(CPF) ON DELETE SET NULL
);

CREATE TABLE ESPECIALCUIDADO(
  NROESPECIAL INTEGER,
  CUIDADO VARCHAR(50),
  CONSTRAINT FKEC FOREIGN KEY (NROESPECIAL) REFERENCES ESPECIAL(NROESPECIAL) ON DELETE CASCADE,
  CONSTRAINT PKEC PRIMARY KEY (NROESPECIAL,CUIDADO)
);

INSERT INTO AULAPESSOA(CPF, NOME) VALUES ('1111','ANA');
INSERT INTO AULAPESSOA(CPF,NOME) VALUES ('2222','BRUNO');
INSERT INTO AULAPESSOA(CPF,NOME) VALUES('3333','CAMILA');
INSERT INTO AULAPESSOA(CPF,NOME) VALUES('4444','DANIEL');
INSERT INTO AULAPESSOA(CPF,NOME) VALUES('5555','ERICA');

INSERT INTO PESSOAHABILIDADE(CPF,HABILIDADE) VALUES ('1111','ATENCAO LONGA');
INSERT INTO PESSOAHABILIDADE(CPF,HABILIDADE) VALUES ('1111', 'PACIENCIA');
INSERT INTO PESSOAHABILIDADE(CPF,HABILIDADE) VALUES ('1111', 'HONESTIDADE');
INSERT INTO PESSOAHABILIDADE(CPF,HABILIDADE) VALUES ('2222','FORCA');
INSERT INTO PESSOAHABILIDADE(CPF,HABILIDADE) VALUES ('2222','CALMA');
INSERT INTO PESSOAHABILIDADE(CPF,HABILIDADE) VALUES ('2222','CORAGEM');
INSERT INTO PESSOAHABILIDADE(CPF,HABILIDADE) VALUES ('3333','ATENCAO LONGA');
INSERT INTO PESSOAHABILIDADE(CPF,HABILIDADE) VALUES ('3333','PACIENCIA');
INSERT INTO PESSOAHABILIDADE(CPF,HABILIDADE) VALUES ('3333','HONESTIDADE');
INSERT INTO PESSOAHABILIDADE(CPF,HABILIDADE) VALUES ('3333','EMPATIA');

CREATE SEQUENCE CONTADORESPECIAL
  START WITH 1
  INCREMENT BY 1;

SELECT sequence_name, last_number
FROM user_sequences;

INSERT INTO ESPECIAL(NROESPECIAL,CPFESPECIAL,CPFSUPERVISOR) VALUES (CONTADORESPECIAL.NEXTVAL,'1111','2222');
INSERT INTO ESPECIAL(NROESPECIAL,CPFESPECIAL,CPFSUPERVISOR) VALUES (CONTADORESPECIAL.NEXTVAL,'3333','4444');

INSERT INTO ESPECIAL(NROESPECIAL,CPFESPECIAL,CPFSUPERVISOR,APELIDO) VALUES (CONTADORESPECIAL.NEXTVAL,'4444','5555','DIDI');
INSERT INTO ESPECIAL(NROESPECIAL,CPFESPECIAL,CPFSUPERVISOR,APELIDO) VALUES (CONTADORESPECIAL.NEXTVAL,'5555','1111','CACA');

INSERT INTO ESPECIALCUIDADO(NROESPECIAL,CUIDADO) VALUES(1,'NAO FALAR ALTO');
INSERT INTO ESPECIALCUIDADO(NROESPECIAL,CUIDADO) VALUES(1,'FALAR DEVAGAR');
INSERT INTO ESPECIALCUIDADO(NROESPECIAL,CUIDADO) VALUES(1,'USAR CANETA PRETA');
INSERT INTO ESPECIALCUIDADO(NROESPECIAL,CUIDADO) VALUES(2,'FORNECER AGUA');
INSERT INTO ESPECIALCUIDADO(NROESPECIAL,CUIDADO) VALUES(2,'MANTER AMBIENTE FRIO');
INSERT INTO ESPECIALCUIDADO(NROESPECIAL,CUIDADO) VALUES(2,'AJUDA NO TRACADO');

CREATE OR REPLACE VIEW PESSOASHABILCUIDADOS AS
  SELECT P.CPF,P.NOME,E.NROESPECIAL,H.HABILIDADE,C.CUIDADO
  FROM AULAPESSOA P,ESPECIAL E,PESSOAHABILIDADE H, ESPECIALCUIDADO C
  WHERE E.CPFESPECIAL=P.CPF AND 
    H.CPF=P.CPF AND
    C.NROESPECIAL=E.NROESPECIAL;
    
SELECT * FROM PESSOASHABILCUIDADOS;

DROP VIEW PESSOASHABILCUIDADOS;

--

CREATE OR REPLACE PROCEDURE atualizaapelido
  (nro IN integer, apel IN varchar)
  IS 
  BEGIN
    UPDATE ESPECIAL E 
    SET E.APELIDO = apel 
    WHERE E.NROESPECIAL = nro;
END;

BEGIN
atualizaapelido(1,'nene')
END;

SELECT * FROM ESPECIAL;

DROP PROCEDURE atualizaapelido;

--

-- funções
-- Podem receber apenas parâmetros de entrada e devolvem um valor em seu nome.

CREATE OR REPLACE FUNCTION CONTAHABILIDADES
  (CPFI IN NUMBER)
  RETURN INTEGER
  IS 
    SOMA INTEGER;
  BEGIN
    SELECT COUNT(HABILIDADE) INTO SOMA -- cursor?
    FROM PESSOAHABILIDADE
    WHERE CPF = CPFI
  RETURN SOMA
  END;
  
  SELECT CONTAHABILIDADES(1111)
  FROM DUAL;
  
  -- Oracle's SQL syntax requires the FROM clause but some queries don't require 
  -- any tables - DUAL can be readily used in these cases.
  
  --
  
  
  
  
  
  
  
  


 
 
  




