--[OBJETIVO]
-- Este script realiza duas operações principais:
-- 1. Atualiza o valor total de cada pedido na tabela db_pedido, 
--    com base na soma dos itens do pedido (quantidade × valor unitário).
-- 2. Gera um resumo mensal e anual de vendas por loja, contendo:
--    total vendido, maior venda, menor venda e média de vendas.
--    Esses dados são inseridos na tabela db_loja_resumo_venda_ano_mes.

-- Atualizando os valores totais dos pedidos
UPDATE db_pedido p
SET vl_tot_pedido = (
    SELECT SUM(ip.qt_pedido * ip.vl_unitario)
    FROM db_item_pedido ip
    WHERE ip.nr_pedido = p.nr_pedido
      AND ip.nr_loja = p.nr_loja
);

SET SERVEROUTPUT ON;

DECLARE
    v_qt_linhas_processadas NUMBER := 0;
BEGIN
    FOR c IN(
        SELECT 
             l.nr_loja,
             EXTRACT(YEAR FROM p.dt_pedido)  ANO_VENDA,
             EXTRACT(MONTH FROM p.dt_pedido) MES_VENDA,
             l.nm_loja,
             SUM(p.vl_tot_pedido)            TOTAL_VENDA, 
             MAX(p.vl_tot_pedido)            MAIOR_VENDA,
             MIN(p.vl_tot_pedido)            MENOR_VENDA,
             ROUND(AVG(p.vl_tot_pedido),2)   MEDIA_VENDA
        FROM db_loja l
        JOIN db_pedido p
            ON (p.nr_loja = l.nr_loja)
        GROUP BY 
            l.nr_loja,
            l.nm_loja,
            EXTRACT(YEAR FROM p.dt_pedido),
            EXTRACT(MONTH FROM p.dt_pedido)
    )
    LOOP
        BEGIN
            INSERT INTO db_loja_resumo_venda_ano_mes 
            (nr_loja, nr_ano, nr_mes, nm_loja, vl_total_venda,
             vl_maior_venda_feita, vl_menor_venda_feita, vl_medio_venda) 
            VALUES
            (c.nr_loja, c.ano_venda, c.mes_venda, c.nm_loja,
             c.total_venda, c.maior_venda, c.menor_venda, c.media_venda);
                 
            v_qt_linhas_processadas := v_qt_linhas_processadas + SQL%ROWCOUNT;
            
        EXCEPTION
            WHEN OTHERS THEN
                dbms_output.put_line('ERROR: ' || SQLERRM);
                ROLLBACK;
        END;
    END LOOP;
    
    dbms_output.put_line('QTD de linhas processadas: ' || v_qt_linhas_processadas);
END;
/
