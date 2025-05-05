-- CAP 7
SET SERVEROUTPUT ON;

DECLARE
    v_nr_cliente db_pedido.nr_cliente%TYPE;
    v_ds_forma_pagto db_forma_pagamento.ds_forma_pagto%TYPE;
    v_qt_vezes_utilizadas INTEGER := 0;
    
BEGIN
    v_nr_cliente := &Informe_o_número_do_cliente;
    
    SELECT fp.ds_forma_pagto, COUNT(*) qtd_utilizadas
    INTO v_ds_forma_pagto, v_qt_vezes_utilizadas
    FROM db_forma_pagamento fp
    JOIN db_pedido p
        ON (p.cd_forma_pagto = fp.cd_forma_pagto)
    WHERE (p.nr_cliente = v_nr_cliente)
    GROUP BY
        fp.ds_forma_pagto
    FETCH FIRST 1 ROWS ONLY;
    
    dbms_output.put_line('O cliente ' || v_nr_cliente || ' utilizou a forma de pagamento '
                         || v_ds_forma_pagto || ' ' || v_qt_vezes_utilizadas || ' Vezes');
    
END;
----------------------------------------------------------------------------------------------


SET SERVEROUTPUT ON;
DECLARE
    v_qtd_dias_vida NUMBER;
    v_nr_cliente db_cliente.nr_cliente%TYPE;
    v_nm_cliente db_cliente.nm_cliente%TYPE;
    v_dt_nascimento db_cli_fisica.dt_nascimento%TYPE;
    v_dia_semana_nasc VARCHAR2(15) DEFAULT 'Domingo';

BEGIN
    v_nr_cliente := &Informe_o_número_do_cliente;
    SELECT c.nr_cliente, 
       c.nm_cliente, 
       cf.dt_nascimento, 
       TO_CHAR(cf.dt_nascimento, 'DAY') dia_semana,
       TRUNC(sysdate - cf.dt_nascimento) dias_nasc
    INTO v_nr_cliente,
         v_nm_cliente, 
         v_dt_nascimento,
         v_dia_semana_nasc,
         v_qtd_dias_vida
    FROM db_cliente c
    JOIN db_cli_fisica cf
        ON (cf.nr_cliente = c.nr_cliente)
    WHERE v_nr_cliente = c.nr_cliente
    FETCH FIRST 1 ROWS ONLY;
    
    dbms_output.put_line('O cliente ' || v_nr_cliente || ' - ' || v_nm_cliente
                         || ' Nasceu em '|| v_dt_nascimento || ' e possui ' || v_qtd_dias_vida
                         || ' dias de vida.');
END;











