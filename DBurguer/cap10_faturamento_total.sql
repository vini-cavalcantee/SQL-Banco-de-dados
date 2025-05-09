/*
    Este algoritmo PL/SQL tem como objetivo alimentar diariamente a tabela `db_faturamento_produto` 
    com dados consolidados de faturamento por produto. Ele extrai, por mês e produto, as seguintes informações:
    - Data no formato ano/mês do pedido;
    - Código do produto;
    - Quantidade vendida;
    - Valor total das vendas;
    - Lucro líquido do produto.

    Os dados são coletados da junção entre os pedidos e os itens dos pedidos, processados em memória,
    e inseridos na tabela de faturamento para futuras análises gerenciais.
*/
SET SERVEROUTPUT ON;

DECLARE
    TYPE rec_fat_total IS RECORD
    (nr_ano_mes          VARCHAR2(7),
     cd_produto          NUMBER(10),
     qt_pdr_vendido      NUMBER(10,2),
     vl_tot_pdr_vendidos NUMBER(10,2),
     vl_lucro_produto    NUMBER(10,2));

    TYPE tof_faturamento IS TABLE OF rec_fat_total;
    
    va_faturamento tof_faturamento;

BEGIN
    va_faturamento := tof_faturamento();
    
    SELECT
        TO_CHAR(p.dt_pedido, 'YYYY/MM') ano_mes_pedido,
        prd.cd_produto,
        ip.qt_pedido, 
        (ip.qt_pedido * ip.vl_unitario),
        ip.vl_lucro_liquido
    BULK COLLECT INTO va_faturamento
    FROM 
        db_item_pedido ip 
    JOIN db_pedido p 
        ON p.nr_pedido = ip.nr_pedido
    JOIN db_produto prd
        ON prd.cd_produto = ip.nr_item;

    FOR xpto IN va_faturamento.FIRST..va_faturamento.LAST
    LOOP
        
        INSERT INTO db_faturamento_produto VALUES
        (va_faturamento(xpto).nr_ano_mes,
         va_faturamento(xpto).cd_produto,
         va_faturamento(xpto).qt_pdr_vendido,
         va_faturamento(xpto).vl_tot_pdr_vendidos,
         va_faturamento(xpto).vl_lucro_produto);
     
    END LOOP;
    
    COMMIT;
    
    dbms_output.put_line('Att Concluida');
    dbms_output.put_line('Att: '|| va_faturamento.COUNT);
    
END;