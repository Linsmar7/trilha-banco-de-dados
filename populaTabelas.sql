-- Populando a tabela tbl_categoria
INSERT INTO tbl_categoria (cp_cod_categoria, nm_categoria)
VALUES 
  (1, 'Bebidas'),
  (2, 'Snacks'),
  (3, 'Congelados'),
  (4, 'Higiene'),
  (5, 'Utensílios');

-- Populando a tabela tbl_estabelecimento
INSERT INTO tbl_estabelecimento (cp_cod_estab, nm_estab, cnpj_estab, localizacao_estab, endereco_estab, UF_estab, cidade_estab)
VALUES 
  (1, 'Loja Central', '12345678000101', ARRAY[1.23, 2.34, 3.45, 4.56], 'Rua A, 100', 'SP', '12345'),
  (2, 'Depósito Central', '12345678000202', ARRAY[5.67, 6.78, 7.89, 8.90], 'Rua B, 200', 'SP', '12345'),
  (3, 'Loja Zona Sul', '12345678000303', ARRAY[9.01, 10.12, 11.13, 12.14], 'Rua C, 300', 'RJ', '54321');

-- Populando a tabela tbl_fornecedor
INSERT INTO tbl_fornecedor (cp_cod_forn, cnpj_forn, localizacao_forn, endereco_forn, UF_forn, cidade_forn)
VALUES 
  (1, '98765432000101', ARRAY[15.15, 16.16, 17.17, 18.18], 'Avenida X, 123', 'SP', '12345'),
  (2, '98765432000202', ARRAY[19.19, 20.20, 21.21, 22.22], 'Avenida Y, 456', 'RJ', '54321');

-- Populando a tabela tbl_funcionario
INSERT INTO tbl_funcionario (cp_cod_func, nm_func, cpf_func, funcao_func)
VALUES 
  (1, 'Alice Souza', '11122233344', 'Repositor'),
  (2, 'Bob Oliveira', '55566677788', 'Gerente');

-- Populando a tabela tbl_rfid
DO $$
DECLARE
  i INT;
BEGIN
  FOR i IN 1..200 LOOP
    INSERT INTO tbl_rfid (cp_id_dispositivo, ind_venda_dispositivo)
    VALUES (i, FALSE);
  END LOOP;
END $$;

-- Populando a tabela tbl_produto
DO $$
DECLARE
  i INT;
  categoria_principal INT;
  categoria_secundaria INT;
BEGIN
  FOR i IN 1..200 LOOP
    categoria_principal := (i % 5) + 1;
    categoria_secundaria := ((i + 2) % 5) + 1;
    INSERT INTO tbl_produto (cp_id_produto, nm_prod, cd_ean_prod, ce_rfid, ce_categoria_principal, ce_categoria_secundaria)
    VALUES 
      (i, 'Produto ' || i, LPAD(i::TEXT, 12, '0'), i, categoria_principal, categoria_secundaria);
  END LOOP;
END $$;

-- Populando a tabela tbl_estoque
DO $$
DECLARE
  i INT;
  estabelecimento_id INT;
  produto_id INT;
BEGIN
  FOR i IN 1..200 LOOP
    estabelecimento_id := (i % 3) + 1; -- Alterna entre os 3 estabelecimentos
    produto_id := i;
    INSERT INTO tbl_estoque (cp_id_produto, cp_cod_estab, quantidade, status_estoque, data_entrada, data_saida)
    VALUES 
      (produto_id, estabelecimento_id, 100, TRUE, NOW(), NULL); -- 100 unidades por produto, disponíveis
  END LOOP;
END $$;


-- Populando a tabela tbl_fornecedor_produto
DO $$
DECLARE
  i INT;
  fornecedor_id INT;
  produto_id INT;
BEGIN
  FOR i IN 1..200 LOOP
    fornecedor_id := (i % 2) + 1; -- Alterna entre os 2 fornecedores
    produto_id := i;
    INSERT INTO tbl_fornecedor_produto (cp_cod_forn, cp_id_produto)
    VALUES 
      (fornecedor_id, produto_id);

    -- Populando preços para cada fornecedor-produto em tbl_precos_fornecedores
    INSERT INTO tbl_precos_fornecedores (cp_cod_forn, cp_id_produto, preco, data_venda, data_vencimento)
    VALUES 
      (fornecedor_id, produto_id, (i * 0.1 + 1)::NUMERIC(10, 2), NOW() - INTERVAL '30 days', NOW() + INTERVAL '1 year');
  END LOOP;
END $$;
