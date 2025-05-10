SET SERVEROUTPUT ON;

DECLARE
    v_qtd_linhas_processadas NUMBER := 0;
    
    v_qtd_tot_produto  NUMBER;
    v_maior_venda      NUMBER(10,2);
    v_menor_venda      NUMBER(10,2);
    v_media_venda      NUMBER(10,2);
    v_total__venda_ano NUMBER(10,2);
    
    v_exception_prd_sem_venda EXCEPTION;
    PRAGMA EXCEPTION_INIT(v_exception_prd_sem_venda, -20234);
    
BEGIN
    for c IN (SELECT cd_produto, ds_produto 
              FROM db_produto)
    
    LOOP
        BEGIN
         SELECT  
            SUM(ip.qt_pedido) qtd_tot_pedido,
            SUM(pe.vl_tot_pedido) vl_total_ano,
            MAX(pe.vl_tot_pedido) vl_maior_venda,
            MIN(pe.vl_tot_pedido) vl_menor_venda,
            ROUND(AVG(pe.vl_tot_pedido), 2) vl_media_venda
         INTO v_qtd_tot_produto, v_total__venda_ano,v_maior_venda, v_menor_venda, v_media_venda
         FROM db_produto      p
         JOIN db_produto_loja pl ON (pl.cd_produto = p.cd_produto)
         JOIN db_item_pedido  ip ON (ip.nr_loja = pl.nr_loja)
         JOIN db_pedido       pe ON (pe.nr_pedido = ip.nr_pedido)
         WHERE 	EXTRACT(YEAR FROM pe.dt_pedido) = EXTRACT(YEAR FROM sysdate)
         AND p.cd_produto = c.cd_produto;
        
        IF v_qtd_tot_produto IS NULL OR v_qtd_tot_produto = 0 THEN
            RAISE v_exception_prd_sem_venda;
        END IF;
        
                
        INSERT INTO db_resumo_venda_produto_ano 
        (cd_produto, ds_produto, nr_ano, qt_vendas_ano, vl_total_venda_ano,
         vl_maior_venda_feita_ano, vl_menor_venda_feita_ano, vl_medio_venda_ano)
        VALUES
        (c.cd_produto, c.ds_produto, EXTRACT(YEAR FROM sysdate), v_qtd_tot_produto, 
         v_total__venda_ano, v_maior_venda, v_menor_venda, v_media_venda);

        v_qtd_linhas_processadas := v_qtd_linhas_processadas + sql%rowcount;
        
        EXCEPTION
            WHEN v_exception_prd_sem_venda THEN
                DBMS_OUTPUT.PUT_LINE('Produto sem vendas no ano: ' || c.cd_produto);
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Erro ao processar produto ' || c.cd_produto || ': ' 
                || SQLERRM);
        
        END;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('QTD LINHAS PROCESSADAS: '|| v_qtd_linhas_processadas);
    
END;

