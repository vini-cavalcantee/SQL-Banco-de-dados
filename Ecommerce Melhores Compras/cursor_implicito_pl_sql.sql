    SET SERVEROUTPUT ON;
    
    DECLARE
        v_qtd_linhas_processadas NUMBER := 0;  
        v_ds_tipo_classificacao_sac VARCHAR2(15);
        v_vl_unitario_lucro_produto NUMBER(10,2);
        
    BEGIN
        FOR C IN(
        SELECT 
            s.nr_sac,
            s.dt_abertura_sac,
            s.hr_abertura_sac,
            s.tp_sac,
            s.nr_indice_satisfacao,
            p.cd_produto,
            p.ds_produto,
            p.vl_unitario,
            p.vl_perc_lucro,
            c.nr_cliente,
            c.nm_cliente,
            e.sg_estado,
            e.nm_estado
        FROM MC_SGV_SAC S 
        JOIN MC_PRODUTO P    ON p.cd_produto = s.cd_produto
        JOIN MC_CLIENTE C    ON c.nr_cliente = s.nr_cliente
        JOIN MC_END_CLI EC   ON ec.nr_cliente = c.nr_cliente
        JOIN MC_LOGRADOURO L ON l.cd_logradouro = ec.cd_logradouro_cli
        JOIN MC_BAIRRO b     ON b.cd_bairro = l.cd_bairro
        JOIN MC_CIDADE ci    ON ci.cd_cidade = b.cd_cidade
        JOIN MC_ESTADO e     ON e.sg_estado = ci.sg_estado)
        
        LOOP
            CASE UPPER(c.tp_sac) 
                WHEN 'S' THEN v_ds_tipo_classificacao_sac := 'SUGESTÃO';
            
                WHEN 'D' THEN v_ds_tipo_classificacao_sac := 'DÚVIDA';
            
                WHEN 'E' THEN v_ds_tipo_classificacao_sac := 'ELOGIO';
      
                ELSE v_ds_tipo_classificacao_sac := 'CLASSIFICAÇÃO INVÁLIDA';
            
            END CASE;
        
            v_vl_unitario_lucro_produto := (c.vl_perc_lucro / 100) * c.vl_unitario;
                
            BEGIN
              INSERT INTO MC_SGV_OCORRENCIA_SAC
              (nr_ocorrencia_sac, dt_abertura_sac, hr_abertura_sac, ds_tipo_classificacao_sac, 
               ds_indice_satisfacao_atd_sac, cd_produto, ds_produto, vl_unitario_produto,
               vl_perc_lucro, vl_unitario_lucro_produto, sg_estado, nm_estado, nr_cliente, 
               nm_cliente, vl_icms_produto) 
               VALUES
               (c.nr_sac, c.dt_abertura_sac, c.hr_abertura_sac, v_ds_tipo_classificacao_sac,
                c.nr_indice_satisfacao, c.cd_produto, c.ds_produto, c.vl_unitario,
                c.vl_perc_lucro, v_vl_unitario_lucro_produto, c.sg_estado, c.nm_estado,
                c.nr_cliente, c.nm_cliente, null);
            
              v_qtd_linhas_processadas := v_qtd_linhas_processadas + sql%rowcount;  
               
              EXCEPTION
                WHEN OTHERS THEN
                    dbms_output.put_line('Erro na linha do SAC ' || c.nr_sac || ': ' || SQLERRM);

            END;
        END LOOP;
        
        dbms_output.put_line('Quantidade de linhas processadas: '|| v_qtd_linhas_processadas);
        
        COMMIT;
    END;    
    