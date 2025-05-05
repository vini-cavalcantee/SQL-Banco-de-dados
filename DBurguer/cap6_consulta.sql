--- CAP 6
SELECT 
    p.cd_produto, p.ds_produto, SUM(ip.qt_pedido) qt_pedido
FROM db_produto p
JOIN db_item_pedido ip 
    ON (ip.nr_item = p.cd_produto)
JOIN db_pedido pe 
    ON (pe.nr_pedido = ip.nr_pedido)
WHERE
    EXTRACT(YEAR FROM SYSDATE) = EXTRACT(YEAR FROM pe.dt_pedido)
GROUP BY
    p.cd_produto, p.ds_produto
ORDER BY qt_pedido DESC;














