-- Este bloco PL/SQL atualiza a quantidade de estrelas e o status de um cliente
-- com base no valor médio de seus pedidos. Caso o valor médio seja baixo, o
-- status do cliente é alterado para 'X'. Ao final, exibe os dados atualizados.

SET SERVEROUTPUT ON;

DECLARE
    v_nr_cliente db_cliente.nr_cliente%TYPE;
    v_qt_estrelas db_cliente.qt_estrelas%TYPE;
    v_media_pedido NUMBER(10,2);
    v_dt_pedido DATE;
    v_st_cliente db_cliente.st_cliente%TYPE;

BEGIN
    v_nr_cliente := &Informe_o_numero_do_cliente;
    
    SELECT  
        c.qt_estrelas,
        MAX(p.dt_pedido), 
        c.vl_medio_compra,
        c.st_cliente
    INTO 
        v_qt_estrelas, v_dt_pedido, v_media_pedido, v_st_cliente
    FROM 
        db_pedido p
    JOIN 
        db_cliente c ON (c.nr_cliente = p.nr_cliente)
    WHERE v_nr_cliente = c.nr_cliente
    GROUP BY c.qt_estrelas, c.vl_medio_compra, c.st_cliente;
    
    CASE
        WHEN v_media_pedido > 399 THEN v_qt_estrelas := 5;
        WHEN v_media_pedido > 360 THEN v_qt_estrelas := 4;
        WHEN v_media_pedido > 320 THEN v_qt_estrelas := 3;
        WHEN v_media_pedido > 280 THEN v_qt_estrelas := 2;
    ELSE
        v_qt_estrelas := 1;
    END CASE;

    UPDATE db_cliente 
    SET qt_estrelas = v_qt_estrelas
    WHERE nr_cliente = v_nr_cliente;
       
    IF v_qt_estrelas IN (1,2) THEN
       v_st_cliente := 'X';
    END IF;
   
    
    UPDATE db_cliente 
    SET st_cliente = v_st_cliente
    WHERE nr_cliente = v_nr_cliente;
        
    dbms_output.put_line('O cliente ' || v_nr_cliente || ' tem em média '|| v_media_pedido
                         ||' de ticket de pedido, ' || v_qt_estrelas || ' estrelas e status: '
                         || v_st_cliente);
    
END;
