-- O script abaixo cria variáveis e faz acesso a dados no projeto DBurger
-- para que o processamento do exercício guiado seja realizado com sucesso
-- PORÉM CERTIFIQUE-SE DE QUE EXISTA UM CÓDIGO DE CLIENTE VÁLIDO, pois caso contrário,

SET SERVEROUTPUT ON;

DECLARE
    v_nr_cliente db_cliente.nr_cliente%TYPE;
    v_nm_cliente db_cliente.nm_cliente%TYPE;
    v_dt_ultimo_pedido DATE;
    v_media_pedido NUMBER(10,2);
        
BEGIN
    v_nr_cliente := &Informe_o_número_do_cliente;
    
    SELECT c.nm_cliente, 
           MAX(p.dt_pedido),
           ROUND(AVG(p.vl_tot_pedido), 2)
    INTO   v_nm_cliente, v_dt_ultimo_pedido, v_media_pedido
    FROM   db_cliente c
    JOIN   db_pedido p
        ON (p.nr_cliente = c.nr_cliente)
    WHERE v_nr_cliente = c.nr_cliente
    GROUP BY c.nm_cliente;
 --   FETCH 1 ROWS ONLY;
    
    dbms_output.put_line('O cliente '|| v_nr_cliente|| ' - '|| v_nm_cliente
                         || ' possui o valor médio de compra de '|| v_media_pedido
                         || ' e comprou pela última vez em '|| v_dt_ultimo_pedido);

END;
----------------------- ATIVIDADE NÃO AVALIATIVA ------------------------------------
-- FAÇA UMA CONSULTA PL/SQL, QUE RETORNE O NOME, SOBRENOME E IDADE 
-- AO INFORMAR UM NÚMERO DE CLIENTE. 

SET SERVEROUTPUT ON;
DECLARE
    v_nr_cliente db_cliente.nr_cliente%TYPE;
    v_primeiro_nome VARCHAR(15);
    v_sobrenome VARCHAR(30);
    v_idade NUMBER;

BEGIN
    v_nr_cliente := &Infome_o_número_do_cliente;
    SELECT
       CASE
          WHEN INSTR(c.nm_cliente, ' ') > 0 THEN 
          SUBSTR(c.nm_cliente, 1, INSTR(c.nm_cliente, ' ') - 1)
          ELSE c.nm_cliente
       END AS primeiro_nome,
       CASE
           WHEN INSTR(c.nm_cliente, ' ') > 0 THEN 
           SUBSTR(c.nm_cliente, INSTR(c.nm_cliente, ' ') + 1)
           ELSE c.nm_cliente
        END AS sobrenome,
        TRUNC((sysdate - cf.dt_nascimento) / 365) idade
    INTO
        v_primeiro_nome, v_sobrenome, v_idade
    FROM 
        db_cliente c
    INNER JOIN 
        db_cli_fisica cf ON (cf.nr_cliente = c.nr_cliente)
    WHERE v_nr_cliente = c.nr_cliente;
    
    dbms_output.put_line('Nome: '|| v_primeiro_nome);
    dbms_output.put_line('Sobrenome: '|| v_sobrenome);
    dbms_output.put_line('Idade: ' || v_idade);

END;
        












