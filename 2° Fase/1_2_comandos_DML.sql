-- POPULAR DADOS A)
-- Inserindo informações na tabela MC_CLIENTE
INSERT INTO MC_CLIENTE
    (NM_CLIENTE, QT_ESTRELAS, VL_MEDIO_COMPRA, 
    ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA)
VALUES
    ('João da Silva', 5, 286.73, 'A', 'joao.silva@email.com.br', 
     '11995400123', 'JoaoSilvaa', 'Silva@123');

INSERT INTO MC_CLIENTE
    (NM_CLIENTE, QT_ESTRELAS, VL_MEDIO_COMPRA, 
     ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA)
VALUES
    ('Maria Aparecida', 4.98, 546.91, 'A', 'aparecida.maria@email.com', 
     '81970012300','MariaAparecia', 'Maria#00');

INSERT INTO MC_CLIENTE
    (NM_CLIENTE, QT_ESTRELAS, VL_MEDIO_COMPRA, 
     ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA)
VALUES
    ('Pedro Oliveira', 3, 1211.75, 'A', 'pedroo.oli@email.com', 
     '41990070032', 'Oliveira123', 'P3dr0Oli');

INSERT INTO MC_CLIENTE
    (NM_CLIENTE, QT_ESTRELAS, VL_MEDIO_COMPRA, 
     ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA)
VALUES
    ('Distribuidora Tech', NULL, 5439.32, 'A', 'tech.distribuidora@tech.com.br', 
     '11949234532', 'TechXX', 'T3ch$001');

INSERT INTO MC_CLIENTE
    (NM_CLIENTE, QT_ESTRELAS, VL_MEDIO_COMPRA, 
     ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA)
VALUES
    ('LTDA System', NULL, 2468.78, 'A', 'systemltda@email.com', 
     '11987009123', 'LTDASYSTEM', 'Ltd@Syst3m');

INSERT INTO MC_CLIENTE
    (NM_CLIENTE, QT_ESTRELAS, VL_MEDIO_COMPRA, 
     ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA)
VALUES
    ('TechFarm', NULL, 1789.77, 'A', 'techfarm@email.com', 
     '11987654321', 'techFARM', 'T3chF4rm_01');

--CLIENTE PESSOA FÍSICA
INSERT INTO MC_CLI_FISICA
    (NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, DS_GENERO, NR_CPF)
VALUES
    (1, TO_DATE('19/12/1995','DD/MM/YYYY'), 'H', 'Homem Cisgênero', '384.269.770-50');

INSERT INTO MC_CLI_FISICA
    (NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, DS_GENERO, NR_CPF)
VALUES
    (2, TO_DATE('25/01/1999', 'DD/MM/YYYY'), 'M', 'Mulher Cisgênero', '217.083.840-20');

INSERT INTO MC_CLI_FISICA
    (NR_CLIENTE, DT_NASCIMENTO, FL_SEXO_BIOLOGICO, DS_GENERO, NR_CPF)
VALUES
    (3, TO_DATE('12/06/2002', 'DD/MM/YYYY'), 'H', 'Homem Cisgênero', '142.698.530-04');

--CLIENTE PESSOA JURIDICA

INSERT INTO MC_CLI_JURIDICA
    (NR_CLIENTE, DT_FUNDACAO, NR_CNPJ, NR_INSCR_EST)
VALUES
    (4, TO_DATE('11/10/2018', 'DD/MM/YYYY'), '63.471.520/0001-03', '110.042.490.114');

INSERT INTO MC_CLI_JURIDICA
    (NR_CLIENTE, DT_FUNDACAO, NR_CNPJ, NR_INSCR_EST)
VALUES
    (5, TO_DATE('30/05/1995', 'DD/MM/YYYY'), '02.948.870/0001-54', NULL);

INSERT INTO MC_CLI_JURIDICA
    (NR_CLIENTE, DT_FUNDACAO, NR_CNPJ, NR_INSCR_EST)
VALUES
    (6, TO_DATE('12/07/2020', 'DD/MM/YYYY'), '88.652.470/0001-89', NULL);

-- Endereços Clientes 
INSERT INTO MC_END_CLI
    (NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, 
     DS_COMPLEMENTO_END, DT_INICIO, DT_TERMINO, ST_END)
VALUES
    (1, 4, 222, 'APTO 31B', TO_DATE('11/05/2024', 'DD/MM/YYYY'), NULL, 'A');

INSERT INTO MC_END_CLI
    (NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, 
     DS_COMPLEMENTO_END, DT_INICIO, DT_TERMINO, ST_END)
VALUES
    (2, 7, 79, NULL, TO_DATE('23/12/2023', 'DD/MM/YYYY'), NULL, 'A');

INSERT INTO MC_END_CLI
    (NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, 
     DS_COMPLEMENTO_END, DT_INICIO, DT_TERMINO, ST_END)
VALUES
    (3, 3, 10, 'Casa 3', TO_DATE('14/03/2024', 'DD/MM/YYYY'), NULL, 'A');

INSERT INTO MC_END_CLI
    (NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, 
     DS_COMPLEMENTO_END, DT_INICIO, DT_TERMINO, ST_END)
VALUES
    (4, 8, 999, '2° Andar', TO_DATE('15/06/2024', 'DD/MM/YYYY'), NULL, 'A');

INSERT INTO MC_END_CLI
    (NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, 
     DS_COMPLEMENTO_END, DT_INICIO, DT_TERMINO, ST_END)
VALUES
    (5, 2, 2525, NULL, TO_DATE('19/02/2023', 'DD/MM/YYYY'), NULL, 'A');

INSERT INTO MC_END_CLI
    (NR_CLIENTE, CD_LOGRADOURO_CLI, NR_END, 
     DS_COMPLEMENTO_END, DT_INICIO, DT_TERMINO, ST_END)
VALUES
    (6, 6, 1245, 'Bloco D', TO_DATE('12/08/2023'), NULL, 'A');
    
-- B)Cadastre um novo cliente que tenha um mesmo login já criado.
--   Foi possível incluir esse novo cliente? Explique.
INSERT INTO MC_CLIENTE
    (NM_CLIENTE, QT_ESTRELAS, VL_MEDIO_COMPRA, 
     ST_CLIENTE, DS_EMAIL, NR_TELEFONE, NM_LOGIN, DS_SENHA)
VALUES
    ('Julia Oliveira', NULL, NULL, 'A', 'juliaoliveira12@email.com', '
     11918273645', 'Oliveira123', 'Juli0aa');
-- Relatório de erros -
--ORA-00001: restrição exclusiva (RM563479.UK_MC_CLIENTE_MM_LOGIN) violada
-- Não é possível realizar esse insert, pois ele vai contra a CONSTRAINT 
--UNIQUE da coluna MN_LOGIN, gerando um erro e impedindo do código ser executado.

-- ALTERAR DADOS
-- C) Selecione um funcionário e atualize o Cargo e aplique 12% de aumento de salário
UPDATE MC_FUNCIONARIO 
SET VL_SALARIO = VL_SALARIO + (VL_SALARIO * 0.12),
    DS_CARGO = 'Gerente de Vendas'
WHERE CD_FUNCIONARIO = 2;

-- D)Selecione um endereço de cliente e coloque o status como inativo 
--   e preencha a data de término (22/04/2025).
UPDATE MC_END_CLI
SET ST_END = 'I',
    DT_TERMINO = TO_DATE('22/04/2025', 'DD/MM/YYYY')
WHERE NR_CLIENTE = 4;

-- E)Tente eliminar um Estado que tenha uma cidade cadastrada. isso foi possível? 
--   Justifique o motivo.
DELETE FROM MC_ESTADO
WHERE SG_ESTADO = 'SP';
--Relatório de erros -
--ORA-02292: restrição de integridade (RM563479.FK_MC_CIDADE_ESTADO) violada
-- Não foi possível excluir o estado com sigla 'SP' porque ele possui cidades 
--cadastradas que estão vinculadas a ele por meio de uma restrição de 
--integridade referencial.

-- F)Selecione um produto e tente atualizar o status do produto com o Status X.
--   Isso foi possível? Justifique o motivo
UPDATE MC_PRODUTO
SET ST_PRODUTO = 'X'
WHERE CD_PRODUTO = 1;
--Relatório de erros -
--ORA-02290: restrição de verificação (RM563479.MC_PRODUTO_CK_ST_PROD) violada
--Não foi possível realizar a ação pois ela viola uma constraint check.

-- G) Confirme todas as transações pendentes
COMMIT