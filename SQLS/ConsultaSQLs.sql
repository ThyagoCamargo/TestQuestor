-- 8.2) A QUANTIDADE DE VENDAS DO CARRO MAREA:
SELECT COUNT(*) AS QTDE_MAREAS_VENDIDOS
FROM VENDAS VEN
JOIN VEICULOS VEI ON (VEI.CODIGO = VEN.CODVEICULO)
WHERE UPPER(VEI.MODELO) = 'MAREA';

-- 8.3)A QUANTIDADE VENDAS DO CARRO UNO POR CLIENTE:
SELECT CLI.NOME, COUNT(*) AS QTDE_COMPRADA
FROM VENDAS VEN
JOIN CLIENTES CLI ON (CLI.CODIGO = VEN.CODCLIENTE)
JOIN VEICULOS VEI ON (VEI.CODIGO = VEN.CODVEICULO)
WHERE UPPER(VEI.MODELO) = 'UNO'
GROUP BY CLI.NOME;

-- 8.4) A quantidade de clientes que n�o efetuaram venda:
SELECT COUNT(*)
FROM CLIENTES CLI
WHERE NOT EXISTS (SELECT VEN.CODIGO
                  FROM VENDAS VEN
                  WHERE VEN.CODCLIENTE = CLI.CODIGO);


--8.5) Os clientes sorteados:
SELECT * FROM VIEWCLIENTESORTEADOS VWCS;

--8.6) Por �ltimo a empresa deseja que voc� exclua todas as vendas que n�o s�o dos clientes sorteados, sem utilizar o comando IN;
DELETE FROM VENDAS VEN
WHERE NOT EXISTS(SELECT CODIGOCLIENTE
                 FROM VIEWCLIENTESORTEADOS VWCS
                 WHERE VWCS.CODIGOCLIENTE = VEN.CODCLIENTE);