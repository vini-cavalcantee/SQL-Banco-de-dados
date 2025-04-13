-- Tabela Categoria
CREATE TABLE T_ECM_CATEGORIA 
    (cd_categoria NUMBER GENERATED ALWAYS AS IDENTITY, 
     st_categoria CHAR (1)        NOT NULL, 
     ds_categoria VARCHAR2 (200)  NOT NULL, 
     dt_inicio    DATE            NOT NULL, 
     dt_termino   DATE );


COMMENT ON COLUMN T_ECM_CATEGORIA.cd_categoria IS 'Essa coluna irá armazenar a chave primária da tabela de categoria. A cada categoria cadastrado será acionada a Sequence  SQ_CD_CATEGORIA que se encarregará de gerar o próximo número único da categoria.' ;
COMMENT ON COLUMN T_ECM_CATEGORIA.st_categoria IS 'Status da categoria. A - Ativo; I - Inativo. Seu conteúdo é obrigatório e deve receber uma constraint Check.' ;
COMMENT ON COLUMN T_ECM_CATEGORIA.ds_categoria IS 'Texto descritivo indicando as caracteristicas da categoria. Conteúdo obrigatório.' ;
COMMENT ON COLUMN T_ECM_CATEGORIA.dt_inicio IS 'Data em que a categoria é criada. Deve ser obrigatório.' ;
COMMENT ON COLUMN T_ECM_CATEGORIA.dt_termino IS 'Data do termino da categoria. Conteúdo opcional.' ;

ALTER TABLE T_ECM_CATEGORIA 
    ADD CONSTRAINT ck_ecm_st_categoria 
    CHECK (st_categoria IN ('A', 'I'));
    
ALTER TABLE T_ECM_CATEGORIA 
    ADD CONSTRAINT pk_ecm_categoria PRIMARY KEY ( cd_categoria ) ;

ALTER TABLE T_ECM_CATEGORIA 
    ADD CONSTRAINT un_ecm_ds_categoria UNIQUE ( ds_categoria ) ;

--Tabela Chamado
CREATE TABLE T_ECM_CHAMADO ( 
     cd_chamado           NUMBER (10) GENERATED ALWAYS AS IDENTITY, 
     cd_cliente           NUMBER           NOT NULL, 
     cd_funcionario       NUMBER           NOT NULL, 
     cd_produto           NUMBER           NOT NULL, 
     cl_tipo_chamado      CHAR (1)         NOT NULL, 
     st_chamado           CHAR (1)         NOT NULL, 
     tx_cliente           VARCHAR2 (4000)  NOT NULL, 
     dt_hr_abertura       DATE             NOT NULL, 
     dt_hr_atendimento    DATE , 
     tp_total_atendimento NUMBER (5,2) , 
     in_satisfacao        NUMBER (2));

COMMENT ON COLUMN T_ECM_CHAMADO.cd_chamado IS 'Código identificador do chamado (Chave primária)' ;

COMMENT ON COLUMN T_ECM_CHAMADO.cd_cliente IS 'Código do cliente que abriu o chamado (Chave estrangeira)' ;

COMMENT ON COLUMN T_ECM_CHAMADO.cd_funcionario IS 'Código do funcionário que vai atender o chamado (Chave estrangeira)' ;

COMMENT ON COLUMN T_ECM_CHAMADO.cd_produto IS 'Código identificador do produto que ocasionou o chamado' ;

COMMENT ON COLUMN T_ECM_CHAMADO.cl_tipo_chamado IS 'Tipo do chamado. 1 - Sugestão. 2 - Reclamação. Seu conteúdo é obrigatório. Criar uma constraint Check' ;

COMMENT ON COLUMN T_ECM_CHAMADO.st_chamado IS 'Classificação do chamado. 
"A" (Aberto); "E" (Em atendimento);"C" (Cancelado); "F" (Fechado com sucesso); "X (Fechado com insatisfação do cliente)". Criar uma constraint Check.' ;

COMMENT ON COLUMN T_ECM_CHAMADO.tx_cliente IS 'Texto escrito pelo cliente descrevendo o porque do chamado' ;

COMMENT ON COLUMN T_ECM_CHAMADO.dt_hr_abertura IS 'Data e hora da abertura do chamado' ;

COMMENT ON COLUMN T_ECM_CHAMADO.dt_hr_atendimento IS 'Data e hora do atendimento do chamado.' ;

COMMENT ON COLUMN T_ECM_CHAMADO.tp_total_atendimento IS 'Tempo total de atendimento do chamado desde a sua abertura até a conclusão.' ;

COMMENT ON COLUMN T_ECM_CHAMADO.in_satisfacao IS 'Indice de satisfação do cliente. 1 - Menos satisfeito; 10 - Cliente mais satisfeito. 
Esse atributo é opcional, prenchido pelo cliente no final do atendimento. Criar uma constraint Check' ;

ALTER TABLE T_ECM_CHAMADO 
    ADD CONSTRAINT ck_ecm_st_chamado 
    CHECK (st_chamado IN ('A', 'E', 'C', 'F', 'X'));


ALTER TABLE T_ECM_CHAMADO 
    ADD CONSTRAINT ck_ecm_tp_chamado 
    CHECK (cl_tipo_chamado IN (1, 2));


ALTER TABLE T_ECM_CHAMADO 
    ADD CONSTRAINT ck_ecm_in_satisfacao 
    CHECK (in_satisfacao BETWEEN 1 AND 10);
    
ALTER TABLE T_ECM_CHAMADO 
    ADD CONSTRAINT pk_ecm_chamados PRIMARY KEY ( cd_chamado ) ;

--Tabela Classificacão
CREATE TABLE T_ECM_CLASSIFICACAO 
    (cd_classificacao NUMBER GENERATED ALWAYS AS IDENTITY, 
     ds_classificacao VARCHAR2 (300)  NOT NULL );

COMMENT ON COLUMN T_ECM_CLASSIFICACAO.cd_classificacao IS 'Código identificador da tabela T_ECM_CLASSIFICACAO (chave primária). Seu conteúdo deve ser obrigatório e único. Deve ser gerado pela chamada IDENTITY.' ;
COMMENT ON COLUMN T_ECM_CLASSIFICACAO.ds_classificacao IS 'Descrição da categoria do produto. Seu conteúdo deve ser obrigatório e único.' ;

ALTER TABLE T_ECM_CLASSIFICACAO 
    ADD CONSTRAINT pk_ecm_classificacao PRIMARY KEY ( cd_classificacao ) ;

--Tabela Cliente
CREATE TABLE T_ECM_CLIENTE 
    (cd_cliente  NUMBER GENERATED ALWAYS AS IDENTITY, 
     nm_cliente  VARCHAR2 (50)  NOT NULL , 
     st_cliente  CHAR (1)       NOT NULL , 
     lg_cliente  VARCHAR2 (30)  NOT NULL , 
     sn_cliente  VARCHAR2 (20)  NOT NULL , 
     qt_estrelas NUMBER (1), 
     tp_cliente  CHAR (1)       NOT NULL );

COMMENT ON COLUMN T_ECM_CLIENTE.cd_cliente IS 'Esse atributo constará o código identificador do cliente (chave primária). Seu conteúdo deve ser obrigatório e único.' ;

COMMENT ON COLUMN T_ECM_CLIENTE.nm_cliente IS 'Esse atributo descreverá o nome completo do cliente, sem abreviação. Seu conteúdo é obrigatório.' ;

COMMENT ON COLUMN T_ECM_CLIENTE.st_cliente IS 'Status do cliente -> A - Ativo; I-Inativo. Conteúdo obrigatório. Criar uma constraint Check.' ;

COMMENT ON COLUMN T_ECM_CLIENTE.lg_cliente IS 'Esse atributo receberá o login do cliente. Seu conteúdo é obrigatório e único.' ;

COMMENT ON COLUMN T_ECM_CLIENTE.sn_cliente IS 'Recebe a senha do cliente. Seu conteúdo é obrigatório.' ;

COMMENT ON COLUMN T_ECM_CLIENTE.qt_estrelas IS 'Quantidade de estrelas que o cliente possui, varia de 1 a 5. Seu conteúdo é opcional e deve receber uma constraint Check.' ;

COMMENT ON COLUMN T_ECM_CLIENTE.tp_cliente IS 'Diferencia se o cliente é físico (F) ou jurídico (J). Seu conteúdo é obrigatório e deve receber uma constraint Check' ;

ALTER TABLE T_ECM_CLIENTE 
    ADD CONSTRAINT ck_ecm_st_cliente 
    CHECK (st_cliente IN ('A', 'I'));


ALTER TABLE T_ECM_CLIENTE 
    ADD CONSTRAINT ck_ecm_tp_cliente 
    CHECK (tp_cliente IN ('F', 'J'));
    
ALTER TABLE T_ECM_CLIENTE 
    ADD CONSTRAINT pk_ecm_cliente PRIMARY KEY ( cd_cliente );

ALTER TABLE T_ECM_CLIENTE 
    ADD CONSTRAINT un_ecm_lg_cliente UNIQUE ( lg_cliente );

--Tabela Departamento
CREATE TABLE T_ECM_DEPARTAMENTO 
    (cd_departamento NUMBER GENERATED ALWAYS AS IDENTITY, 
     nm_departamento VARCHAR2 (50)  NOT NULL , 
     sg_departamento CHAR (3)       NOT NULL );

COMMENT ON COLUMN T_ECM_DEPARTAMENTO.cd_departamento IS 'Esse atributo é o código identificador da tabela Departamento (chave primária). Seu conteúdo deve ser obrigatório e único.' ;

COMMENT ON COLUMN T_ECM_DEPARTAMENTO.nm_departamento IS 'Esse atributo recebe o nome do departamento.Seu conteúdo deve ser obrigatório e único. Crie uma CONSTRAINT UNIQUE para esse atributo.' ;

COMMENT ON COLUMN T_ECM_DEPARTAMENTO.sg_departamento IS 'Esse atributo recebe a Sigla do departamento, essa sigla recebe 3 letras. Seu conteúdo deve ser obrigatório e único. Crie uma CONSTRAINT UNIQUE.' ;

ALTER TABLE T_ECM_DEPARTAMENTO 
    ADD CONSTRAINT pk_ecm_departamento PRIMARY KEY ( cd_departamento ) ;

ALTER TABLE T_ECM_DEPARTAMENTO 
    ADD CONSTRAINT un_ecm_nm_departamento UNIQUE ( nm_departamento ) ;

ALTER TABLE T_ECM_DEPARTAMENTO 
    ADD CONSTRAINT un_ecm_sg_departamento UNIQUE ( sg_departamento ) ;

--Tabela Devolução
CREATE TABLE T_ECM_DEVOLUCAO 
    (cd_devolucao   NUMBER GENERATED ALWAYS AS IDENTITY, 
     cd_chamado     NUMBER (10)  NOT NULL , 
     dt_devolucao   DATE  NOT NULL , 
     dt_recebimento DATE , 
     st_devolucao   CHAR (1)  NOT NULL , 
     st_estorno     CHAR (1)  NOT NULL , 
     ds_devolucao   VARCHAR2 (300)  NOT NULL ) ;

COMMENT ON COLUMN T_ECM_DEVOLUCAO.cd_devolucao IS 'Código primário identificador da tabela T_ECM_DEVOLUCAO. Seu conteúdo deve ser obrigatório e único. Deve ser gerado pela chamada IDENTITY.' ;

COMMENT ON COLUMN T_ECM_DEVOLUCAO.cd_chamado IS 'Chave estrangeira da tabela T_ECM_CHAMADOS. Esse atributo faz parte da chave primária da tabela Devolução. Seu conteúdo deve ser obrigatório e único.' ;

COMMENT ON COLUMN T_ECM_DEVOLUCAO.dt_devolucao IS 'Data em que o cliente realizou a devolução do produto.Seu conteúdo deve ser obrigatório.' ;

COMMENT ON COLUMN T_ECM_DEVOLUCAO.dt_recebimento IS 'Data que o produto chegou no de volta no estoque da Melhores Compras. Seu conteúdo deve ser obrigatório.' ;

COMMENT ON COLUMN T_ECM_DEVOLUCAO.st_devolucao IS 'Status da devolução. Seu conteúdo deve ser obrigatório. Crie uma constraint Check para esse atributo, onde: P - Pendente (aguardando recebimento); A - Análise do produto devolvido; C-Concluído com sucesso;' ;

COMMENT ON COLUMN T_ECM_DEVOLUCAO.st_estorno IS 'Retorna o status do estorno, indicando se foi aprovado ou não.Seu conteúdo deve ser obrigatóro e receber a constraint  CHECK, onde: A - Aprovado (estorno aprovado); R - Recusado (estorno recusado).';

COMMENT ON COLUMN T_ECM_DEVOLUCAO.ds_devolucao IS 'Texto iindicando  os motivos do estorno ser aprovado ou não. Deve ser preenchido pelo funcionário responsável pelo chamado. Seu conteúdo deve ser obrigatório.';

ALTER TABLE T_ECM_DEVOLUCAO 
    ADD CONSTRAINT ck_ecm_st_devolucao 
    CHECK (st_devolucao IN ('P', 'A', 'C'));

ALTER TABLE T_ECM_DEVOLUCAO 
    ADD CONSTRAINT ck_ecm_st_estorno 
    CHECK (st_estorno IN ('A', 'R'));

ALTER TABLE T_ECM_DEVOLUCAO 
    ADD CONSTRAINT pk_ecm_devolucao PRIMARY KEY ( cd_devolucao, cd_chamado ) ;


--Tabela Cliente Físico
CREATE TABLE T_ECM_FISICO 
    (cd_cliente   NUMBER GENERATED ALWAYS AS IDENTITY, 
     nr_cpf       NUMBER (11)  NOT NULL , 
     dt_nasc      DATE         NOT NULL , 
     sx_biologico CHAR (2)     NOT NULL , 
     gn_nasc      CHAR (1)     NOT NULL );

COMMENT ON COLUMN T_ECM_FISICO.cd_cliente IS 'Essa coluna armazenará o código único do cliente físico. Seu conteúdo deve ser obrigatório  e preenchido a  partir da tabela T_ECM_CLIENTE.' ;

COMMENT ON COLUMN T_ECM_FISICO.nr_cpf IS 'Essa coluna irá armazenar o número do CPF. Seu conteúdo é obrigatorio.' ;

COMMENT ON COLUMN T_ECM_FISICO.dt_nasc IS 'Essa coluna contém a data de nascimneto ( seu conteúdo é obrigatorio )' ;

COMMENT ON COLUMN T_ECM_FISICO.sx_biologico IS 'Sexo biológico. H - Homem; M - Mulher; Criar uma constraint check.' ;

COMMENT ON COLUMN T_ECM_FISICO.gn_nasc IS 'Gênero no nascimento: H - Homem; M - Mulher; O-Outro. Conteúdo opcional.
Criar uma constraint Check.';

ALTER TABLE T_ECM_FISICO 
    ADD CONSTRAINT pk_ecm_fisico PRIMARY KEY ( cd_cliente ) ;

ALTER TABLE T_ECM_FISICO 
    ADD CONSTRAINT un_ecm_cliente_cpf UNIQUE ( nr_cpf ) ;

--Tabela Funcionário
CREATE TABLE T_ECM_FUNCIONARIO 
    (cd_funcionario  NUMBER GENERATED ALWAYS AS IDENTITY, 
     cd_departamento NUMBER         NOT NULL , 
     nm_funcionario  VARCHAR2 (50)  NOT NULL , 
     tx_cargo        VARCHAR2 (30)  NOT NULL , 
     nr_cpf          VARCHAR2 (11)  NOT NULL , 
     dt_nascimento   DATE           NOT NULL , 
     tx_email        VARCHAR2 (50)  NOT NULL );

COMMENT ON COLUMN T_ECM_FUNCIONARIO.cd_funcionario IS 'Essa coluna constará o código identificador do funcionário (chave primária). Seu conteúdo deve ser obrigatório e único.' ;

COMMENT ON COLUMN T_ECM_FUNCIONARIO.cd_departamento IS 'Essa coluna constará a chave estrangeiora da tabela de departamentos (T_ECM_DEPARTAMENTO). Seu conteúdo deve ser obrigatório e único.' ;

COMMENT ON COLUMN T_ECM_FUNCIONARIO.nm_funcionario IS 'Essa coluna descreverá o nome completo do funcionário, sem abreviação. Seu conteúdo é obrigatório. ';

COMMENT ON COLUMN T_ECM_FUNCIONARIO.tx_cargo IS 'Esta coluna receberá o nome do  cargo do funcionário e seu conteúdo é obrigatório.' ;

COMMENT ON COLUMN T_ECM_FUNCIONARIO.nr_cpf IS 'Esta coluna receberá o número do CPF do funcionário. O CPF possui 11 dígitos. Seu conteúdo é obrigatório e  único. Deverá ser inserido o CONSTRAINT UNIQUE.' ;

COMMENT ON COLUMN T_ECM_FUNCIONARIO.dt_nascimento IS 'Esta coluna receberá a data de nascimento do funcionário. Seu conteúdo é obrigatório.' ;

COMMENT ON COLUMN T_ECM_FUNCIONARIO.tx_email IS 'Esta coluna receberá o e-mail do funcionário. Seu conteúdo é obirgatório. Poderá ser criado CONSTRAINT CHECK para o e-mail ter o "@".
CONSTRAINT check_tx_email CHECK (email LIKE ''%@%'').';

ALTER TABLE T_ECM_FUNCIONARIO 
    ADD CONSTRAINT pk_ecm_funcionario PRIMARY KEY ( cd_funcionario ) ;

ALTER TABLE T_ECM_FUNCIONARIO 
    ADD CONSTRAINT un_ecm_funcionario_cpf UNIQUE ( nr_cpf ) ;

--Tabela Cliente Jurídico
CREATE TABLE T_ECM_JURIDICO 
    (cd_cliente            NUMBER GENERATED ALWAYS AS IDENTITY, 
     dt_fundacao           DATE , 
     nr_cnpj               NUMBER (14) , 
     nr_inscricao_estadual NUMBER (20));

COMMENT ON COLUMN T_ECM_JURIDICO.cd_cliente IS 'Essa coluna armazenará o código único do cliente jurídico. Seu conteúdo deve ser obrigatório  e preenchido a  partir da tabela T_ECM_CLIENTE.' ;
COMMENT ON COLUMN T_ECM_JURIDICO.dt_fundacao IS 'Essa coluna armazenará data  de fundação do cliente pessoa jurídica. Seu conteúdo deve ser obrigatório.' ;
COMMENT ON COLUMN T_ECM_JURIDICO.nr_cnpj IS 'Essa coluna armazenará o  numero do CNPJ do cliente pessoa jurídica. Seu conteúdo deve ser obrigatório e único. O CNPJ possui 14 dígitos.' ;
COMMENT ON COLUMN T_ECM_JURIDICO.nr_inscricao_estadual IS 'Essa coluna irá armazenar o  numero da Inscrição Estadual  do cliente pessoa jurídica..Seu conteúdo deve ser opcional e único.' ;

ALTER TABLE T_ECM_JURIDICO 
    ADD CONSTRAINT pk_ecm_cliente_juridico PRIMARY KEY ( cd_cliente ) ;

ALTER TABLE T_ECM_JURIDICO 
    ADD CONSTRAINT un_ecm_juridico_cnpj UNIQUE ( nr_cnpj ) ;

ALTER TABLE T_ECM_JURIDICO 
    ADD CONSTRAINT un_ecm_insc_federal UNIQUE ( nr_inscricao_estadual ) ;

--Tabela Produto
CREATE TABLE T_ECM_PRODUTO 
    (cd_produto      NUMBER GENERATED ALWAYS AS IDENTITY, 
     cd_categoria    NUMBER , 
     pr_unitário     NUMBER (7,2)    NOT NULL , 
     ds_normal       VARCHAR2 (200)  NOT NULL , 
     ds_completa     VARCHAR2 (500)  NOT NULL , 
     cd_barras_EAN13 NUMBER (13));

COMMENT ON COLUMN T_ECM_PRODUTO.cd_produto IS 'Essa coluna irá armazenar a chave primária da tabela de produtos. A cada produto cadastrado será acionada a Sequence  SQ_CD_PRODUTO que se encarregará de gerar o próximo número único do produto.' ;
COMMENT ON COLUMN T_ECM_PRODUTO.cd_categoria IS 'Essa coluna constará a chave primária da tabela de categoria de produtos (T_ECM_CATEGORIA). Cada categoria nova cadastrada  será acionada a Sequence  SQ_CD_CATEGORIA que se encarregará de gerar o próximo número único da categoria.' ;
COMMENT ON COLUMN T_ECM_PRODUTO.pr_unitário IS 'Essa coluna irá armazenar o valor unitário do produto. Seu preenchimento é obrigatório.' ;
COMMENT ON COLUMN T_ECM_PRODUTO.ds_normal IS 'Essa coluna armazenará a descrição principal do produto. Seu conteúdo deve ser  obrigatório.' ;
COMMENT ON COLUMN T_ECM_PRODUTO.ds_completa IS 'Essa coluna armazenará a descrição detalhada do produto. Seu conteúdo deve ser  obrigatório.' ;
COMMENT ON COLUMN T_ECM_PRODUTO.cd_barras_EAN13 IS 'Essa coluna irá armazenar o número do codigo de barras no padrão EAN13. Seu conteúdo é  opcional.' ;

ALTER TABLE T_ECM_PRODUTO 
    ADD CONSTRAINT pk_ecm_produto PRIMARY KEY ( cd_produto ) ;

ALTER TABLE T_ECM_PRODUTO 
    ADD CONSTRAINT un_ecm_produtos_cd_barras UNIQUE ( cd_barras_EAN13 ) ;

--Tabela Telefone
CREATE TABLE T_ECM_TELEFONE 
    (cd_telefone    NUMBER GENERATED ALWAYS AS IDENTITY, 
     cd_funcionario NUMBER , 
     cd_cliente     NUMBER , 
     nr_telefone    NUMBER (9)  NOT NULL , 
     tp_telefone    VARCHAR2 (15)  NOT NULL , 
     nr_ddd         NUMBER (3)  NOT NULL);

COMMENT ON COLUMN T_ECM_TELEFONE.cd_telefone IS 'Código identicador do telefone ( chave primária )  Seu conteúdo deve ser obrigatóri e único.';
COMMENT ON COLUMN T_ECM_TELEFONE.cd_funcionario IS 'Código identicador do funcionario e Chave estrangeira da tabela T_ECM_FUNCIONARIO .  Seu conteúdo deve ser opcional, pois nem todo telefone pertence a um funcionario..' ;
COMMENT ON COLUMN T_ECM_TELEFONE.cd_cliente IS 'Código identicador do cliente e Chave estrangeira da tabela T_ECM_CLIENTE .  Seu conteúdo deve ser opcional, pois nem todo telefone pertence a um cliente..' ;
COMMENT ON COLUMN T_ECM_TELEFONE.nr_telefone IS 'Esse atributo contém o número. Seu conteúdo é obrigatório.' ;
COMMENT ON COLUMN T_ECM_TELEFONE.tp_telefone IS 'Tipo do telefone (Residencial, comercial, celular...). Conteúdo obrigatório.' ;
COMMENT ON COLUMN T_ECM_TELEFONE.nr_ddd IS 'Número do DDD do telefone. Seu conteúdo é obrigatório.';

ALTER TABLE T_ECM_TELEFONE
    ADD CONSTRAINT pk_ecm_telefone PRIMARY KEY (cd_telefone);

--Tabela Video
CREATE TABLE T_ECM_VIDEO 
    (cd_video         NUMBER GENERATED ALWAYS AS IDENTITY , 
     cd_produto       NUMBER    NOT NULL , 
     cd_classificacao NUMBER    NOT NULL , 
     st_video         CHAR (1)  NOT NULL , 
     video            BLOB      NOT NULL );

COMMENT ON COLUMN T_ECM_VIDEO.cd_video IS 'Código identificador da tabela T_ECM_VIDEOS (chave primária). Seu conteúdo deve ser obrigatório e único. Deve ser gerado pela chamada IDENTITY.';
COMMENT ON COLUMN T_ECM_VIDEO.cd_produto IS 'Chave estrangeira da tabela T_ECM_PRODUTOS. Seu conteúdo deve ser obrigatório e único. ' ;
COMMENT ON COLUMN T_ECM_VIDEO.cd_classificacao IS 'Chave estrangeira da tabela T_ECM_CLASSIFICACAO. Seu conteúdo deve ser obrigatório e único.' ;
COMMENT ON COLUMN T_ECM_VIDEO.st_video IS 'Status do vídeo, indicando se ele está ativo ou inativo. Seu conteúdo deve ser obrigatório. Crie uma constraint CHECK, onde: A - Ativo; I - Inativo.' ;
COMMENT ON COLUMN T_ECM_VIDEO.video IS 'Armazena o arquivo do vídeo. Seu conteúdo é obrigatório.' ;

ALTER TABLE T_ECM_VIDEO 
    ADD CONSTRAINT ck_ecm_st_videos 
    CHECK (st_video IN ('A', 'I'));
    
ALTER TABLE T_ECM_VIDEO 
    ADD CONSTRAINT pk_ecm_video PRIMARY KEY ( cd_video ) ;

--Tabela Visualização
CREATE TABLE T_ECM_VISUALIZACAO 
    (cd_visualizacao    NUMBER GENERATED ALWAYS AS IDENTITY, 
     cd_video           NUMBER  NOT NULL , 
     cd_cliente         NUMBER  NOT NULL , 
     dt_hr_visualizacao DATE  NOT NULL , 
     cd_produto         NUMBER  NOT NULL );

COMMENT ON COLUMN T_ECM_VISUALIZACAO.cd_visualizacao IS 'Essa coluna constará o código identificador da visualização (chave primária). Seu conteúdo deve ser obrigatório e único.' ;
COMMENT ON COLUMN T_ECM_VISUALIZACAO.cd_video IS 'Essa coluna armazenará o código único do video. Seu conteúdo deve ser obrigatório  e preenhcido a  partir da tabela T_ECM_VIDEOS (chave primária e  estrangeira).' ;
COMMENT ON COLUMN T_ECM_VISUALIZACAO.cd_cliente IS 'Essa coluna armazenará o código único do cliente.Seu conteúdo deve ser obrigatório  e preenchido a  partir da tabela T_ECM_CLIENTE.' ;
COMMENT ON COLUMN T_ECM_VISUALIZACAO.dt_hr_visualizacao IS 'Data e hora da visualização. Seu conteúdo é obrigatório.' ;
COMMENT ON COLUMN T_ECM_VISUALIZACAO.cd_produto IS 'Essa coluna armazenará o código único do produto. Seu conteúdo deve ser obrigatório  e preenhcido a  partir da tabela T_ECM_PRODUTOS (chave  estrangeira).' ;

ALTER TABLE T_ECM_VISUALIZACAO 
    ADD CONSTRAINT pk_ecm_visualizacao PRIMARY KEY ( cd_visualizacao, cd_video ) ;


--CHAVES ESTRANGEIRAS

-- FK's de Chamado
ALTER TABLE T_ECM_CHAMADO 
    ADD CONSTRAINT fk_ecm_chamado_cliente 
    FOREIGN KEY (cd_cliente) 
    REFERENCES T_ECM_CLIENTE (cd_cliente);

ALTER TABLE T_ECM_CHAMADO 
    ADD CONSTRAINT fk_ecm_chamado_funcionario 
    FOREIGN KEY (cd_funcionario) 
    REFERENCES T_ECM_FUNCIONARIO (cd_funcionario);

ALTER TABLE T_ECM_CHAMADO 
    ADD CONSTRAINT fk_ecm_chamado_produto 
    FOREIGN KEY (cd_produto) 
    REFERENCES T_ECM_PRODUTO (cd_produto);

-- Cliente Físico
ALTER TABLE T_ECM_FISICO 
    ADD CONSTRAINT fk_ecm_cliente_fisico 
    FOREIGN KEY (cd_cliente) 
    REFERENCES T_ECM_CLIENTE (cd_cliente);

-- Cliente Jurídico
ALTER TABLE T_ECM_JURIDICO 
    ADD CONSTRAINT fk_ecm_cliente_juridico 
    FOREIGN KEY (cd_cliente) 
    REFERENCES T_ECM_CLIENTE (cd_cliente);

-- Tabela devolução
ALTER TABLE T_ECM_DEVOLUCAO 
    ADD CONSTRAINT fk_ecm_devolucao_chamado 
    FOREIGN KEY (cd_chamado) 
    REFERENCES T_ECM_CHAMADO (cd_chamado);

--Tabela telefone
ALTER TABLE T_ECM_TELEFONE 
    ADD CONSTRAINT fk_ecm_fone_cliente 
    FOREIGN KEY (cd_cliente) 
    REFERENCES T_ECM_CLIENTE (cd_cliente);

ALTER TABLE T_ECM_TELEFONE 
    ADD CONSTRAINT fk_ecm_fone_funcionario 
    FOREIGN KEY (cd_funcionario) 
    REFERENCES T_ECM_FUNCIONARIO (cd_funcionario);

--Tabela Funcionário
ALTER TABLE T_ECM_FUNCIONARIO 
    ADD CONSTRAINT fk_ecm_funcionario_depto 
    FOREIGN KEY (cd_departamento)
    REFERENCES T_ECM_DEPARTAMENTO (cd_departamento);

--Tabela Produto
ALTER TABLE T_ECM_PRODUTO 
    ADD CONSTRAINT fk_ecm_produto_categoria 
    FOREIGN KEY (cd_categoria)
    REFERENCES T_ECM_CATEGORIA (cd_categoria);

--Tabela Video
ALTER TABLE T_ECM_VIDEO 
    ADD CONSTRAINT fk_ecm_video_classificacao 
    FOREIGN KEY (cd_classificacao) 
    REFERENCES T_ECM_CLASSIFICACAO (cd_classificacao);

ALTER TABLE T_ECM_VIDEO 
    ADD CONSTRAINT fk_ecm_video_produto 
    FOREIGN KEY (cd_produto) 
    REFERENCES T_ECM_PRODUTO (cd_produto);

--Tabela Visualização
ALTER TABLE T_ECM_VISUALIZACAO 
    ADD CONSTRAINT fk_ecm_visualizacao_cliente 
    FOREIGN KEY (cd_cliente) 
    REFERENCES T_ECM_CLIENTE (cd_cliente);

ALTER TABLE T_ECM_VISUALIZACAO 
    ADD CONSTRAINT fk_ecm_visualizacao_video 
    FOREIGN KEY (cd_video) 
    REFERENCES T_ECM_VIDEO (cd_video);


CREATE OR REPLACE TRIGGER FKNTM_T_ECM_VISUALIZACAO 
BEFORE UPDATE OF cd_video 
ON T_ECM_VISUALIZACAO 
BEGIN 
  raise_application_error(-20225,'Non Transferable FK constraint  on table T_ECM_VISUALIZACAO is violated'); 
END; 
/

CREATE OR REPLACE TRIGGER ARC_Arc_2_T_ECM_FISICO 
BEFORE INSERT OR UPDATE OF cd_cliente 
ON T_ECM_FISICO 
FOR EACH ROW 
DECLARE 
    d CHAR (1); 
BEGIN 
    SELECT A.tp_cliente INTO d 
    FROM T_ECM_CLIENTE A 
    WHERE A.cd_cliente = :new.cd_cliente; 
    IF (d IS NULL OR d <> 'F') THEN 
        raise_application_error(-20223,'FK fk_ecm_cliente_fisico in Table T_ECM_FISICO violates Arc constraint on Table T_ECM_CLIENTE - discriminator column tp_cliente doesn''t have value ''F'''); 
    END IF; 
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        NULL; 
    WHEN OTHERS THEN 
        RAISE; 
END; 
/

CREATE OR REPLACE TRIGGER ARC_Arc_2_T_ECM_JURIDICO 
BEFORE INSERT OR UPDATE OF cd_cliente 
ON T_ECM_JURIDICO 
FOR EACH ROW 
DECLARE 
    d CHAR (1); 
BEGIN 
    SELECT A.tp_cliente INTO d 
    FROM T_ECM_CLIENTE A 
    WHERE A.cd_cliente = :new.cd_cliente; 
    IF (d IS NULL OR d <> 'J') THEN 
        raise_application_error(-20223,'FK fk_ecm_cliente_juridico in Table T_ECM_JURIDICO violates Arc constraint on Table T_ECM_CLIENTE - discriminator column tp_cliente doesn''t have value ''J'''); 
    END IF; 
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        NULL; 
    WHEN OTHERS THEN 
        RAISE; 
END; 
/


--Eliminação do Banco de dados Físico
DROP TABLE T_ECM_CATEGORIA CASCADE CONSTRAINT PURGE;
DROP TABLE T_ECM_CHAMADO CASCADE CONSTRAINT PURGE;
DROP TABLE T_ECM_CLASSIFICACAO CASCADE CONSTRAINT PURGE;
DROP TABLE T_ECM_CLIENTE CASCADE CONSTRAINT PURGE;
DROP TABLE T_ECM_DEPARTAMENTO CASCADE CONSTRAINT PURGE;
DROP TABLE T_ECM_DEVOLUCAO CASCADE CONSTRAINT PURGE;
DROP TABLE T_ECM_FISICO CASCADE CONSTRAINT PURGE;
DROP TABLE T_ECM_JURIDICO CASCADE CONSTRAINT PURGE;
DROP TABLE T_ECM_PRODUTO CASCADE CONSTRAINT PURGE;
DROP TABLE T_ECM_TELEFONE CASCADE CONSTRAINT PURGE;
DROP TABLE T_ECM_VIDEO CASCADE CONSTRAINT PURGE;
DROP TABLE T_ECM_VISUALIZACAO CASCADE CONSTRAINT PURGE;
DROP TABLE T_ECM_FUNCIONARIO CASCADE CONSTRAINT PURGE;

