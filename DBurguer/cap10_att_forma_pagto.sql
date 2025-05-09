-- Este bloco PL/SQL atualiza diariamente a tabela `db_ano_mes_forma_pagto`
-- com o total de vendas por forma de pagamento, ano e mês, extraídos da 
-- tabela de pedidos (`db_pedido`). Também insere o nome do mês por extenso.
-- A operação realiza um processamento em memória com `BULK COLLECT` e 
-- insere os dados processados na tabela de destino.

SET SERVEROUTPUT ON;

DECLARE
    TYPE a_mes_extenso IS VARRAY(12) OF VARCHAR2(15);
    va_mes_extenso a_mes_extenso;
    
    TYPE rec_venda_ano_mes IS RECORD
    (cd_forma_pagto NUMBER(5),
     ds_forma_pagto VARCHAR2(30),
     nr_ano         NUMBER(4),
     nr_mes         NUMBER(2),
     vl_total_venda NUMBER(10,2));
     
     TYPE tof_venda_ano_mes_total IS TABLE OF rec_venda_ano_mes;
     
     va_rec_venda_ano_mes_forma_pagto tof_venda_ano_mes_total;
BEGIN
    va_mes_extenso := a_mes_extenso('Janeiro', 'Fevereiro', 'Março', 
    'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');

    va_rec_venda_ano_mes_forma_pagto := tof_venda_ano_mes_total();
    
    SELECT 
        fp.cd_forma_pagto,
        fp.ds_forma_pagto,
        EXTRACT(YEAR FROM p.dt_pedido) ano_venda,
        EXTRACT(MONTH FROM p.dt_pedido) mes_venda,
        SUM(p.vl_tot_pedido) vl_total_venda
    BULK COLLECT INTO va_rec_venda_ano_mes_forma_pagto
    FROM 
        db_forma_pagamento fp
    JOIN db_pedido p
        ON p.cd_forma_pagto = fp.cd_forma_pagto
    GROUP BY
        fp.cd_forma_pagto, fp.ds_forma_pagto, 
        EXTRACT(YEAR FROM p.dt_pedido),
        EXTRACT(MONTH FROM p.dt_pedido)
    ORDER BY 1, 2, 3;
    
    
    FOR xpto IN va_rec_venda_ano_mes_forma_pagto.FIRST..va_rec_venda_ano_mes_forma_pagto.LAST
    LOOP
    
        INSERT INTO db_ano_mes_forma_pagto VALUES
        (va_rec_venda_ano_mes_forma_pagto(xpto).cd_forma_pagto,
         va_rec_venda_ano_mes_forma_pagto(xpto).ds_forma_pagto,
         va_rec_venda_ano_mes_forma_pagto(xpto).nr_ano,
         va_rec_venda_ano_mes_forma_pagto(xpto).nr_mes,
         va_mes_extenso(va_rec_venda_ano_mes_forma_pagto(xpto).nr_mes),
         va_rec_venda_ano_mes_forma_pagto(xpto).vl_total_venda);
         
    END LOOP;
    
    COMMIT;
    
    dbms_output.put_line('Att com sucesso');
    dbms_output.put_line('Formas de pagto att: '|| va_rec_venda_ano_mes_forma_pagto.COUNT);  
    
END;

SELECT * FROM db_ano_mes_forma_pagto