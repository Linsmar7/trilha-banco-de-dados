CREATE TABLE tbl_categoria (
  cp_cod_categoria SERIAL PRIMARY KEY,
  nm_categoria VARCHAR(20) NOT NULL
);

CREATE TABLE tbl_produto (
  cp_id_produto SERIAL PRIMARY KEY,
  nm_prod VARCHAR(60) NOT NULL,
  cd_ean_prod VARCHAR(12) UNIQUE NOT NULL,
  ce_rfid INT NOT NULL,
  ce_categoria_principal INT REFERENCES tbl_categoria(cp_cod_categoria),
  ce_categoria_secundaria INT REFERENCES tbl_categoria(cp_cod_categoria)
);

CREATE TABLE tbl_rfid (
  cp_id_dispositivo SERIAL PRIMARY KEY,
  ind_venda_dispositivo BOOLEAN NOT NULL
);

CREATE TABLE tbl_estabelecimento (
  cp_cod_estab SERIAL PRIMARY KEY,
  nm_estab VARCHAR(60) NOT NULL,
  cnpj_estab VARCHAR(60) NOT NULL,
  localizacao_estab FLOAT8[],
  endereco_estab VARCHAR(200),
  UF_estab VARCHAR(2),
  cidade_estab VARCHAR(5)
);

CREATE TABLE tbl_funcionario (
  cp_cod_func SERIAL PRIMARY KEY,
  nm_func VARCHAR(200) NOT NULL,
  cpf_func VARCHAR(11) UNIQUE NOT NULL,
  funcao_func VARCHAR(40) NOT NULL
);

CREATE TABLE tbl_fornecedor (
  cp_cod_forn SERIAL PRIMARY KEY,
  cnpj_forn VARCHAR(14) NOT NULL,
  localizacao_forn FLOAT8[],
  endereco_forn VARCHAR(200),
  UF_forn VARCHAR(2),
  cidade_forn VARCHAR(5)
);

CREATE TABLE tbl_estoque (
  cp_id_estoque SERIAL PRIMARY KEY,
  cp_id_produto INT REFERENCES tbl_produto(cp_id_produto),
  cp_cod_estab INT REFERENCES tbl_estabelecimento(cp_cod_estab),
  quantidade INT NOT NULL,
  status_estoque BOOLEAN NOT NULL,
  data_entrada DATE NOT NULL,
  data_saida DATE
);

CREATE TABLE tbl_precos_fornecedores (
  cp_id_preco SERIAL PRIMARY KEY,
  cp_cod_forn INT REFERENCES tbl_fornecedor(cp_cod_forn),
  cp_id_produto INT REFERENCES tbl_produto(cp_id_produto),
  preco DECIMAL(10, 2) NOT NULL,
  data_venda DATE NOT NULL,
  data_vencimento DATE NOT NULL
);

CREATE TABLE tbl_movimentacao_estoque (
  cp_id_movimentacao SERIAL PRIMARY KEY,
  cp_id_estoque INT REFERENCES tbl_estoque(cp_id_estoque),
  cp_cod_func INT REFERENCES tbl_funcionario(cp_cod_func),
  tipo_movimentacao VARCHAR(20) NOT NULL,
  quantidade INT NOT NULL,
  data_movimentacao DATE NOT NULL
);

CREATE TABLE tbl_vendas (
  cp_id_venda SERIAL PRIMARY KEY,
  cp_id_produto INT REFERENCES tbl_produto(cp_id_produto),
  cp_cod_estab INT REFERENCES tbl_estabelecimento(cp_cod_estab),
  quantidade INT NOT NULL,
  preco_unitario DECIMAL(10, 2) NOT NULL,
  data_venda DATE NOT NULL
);

CREATE TABLE tbl_fornecedor_produto (
  cp_cod_forn INT REFERENCES tbl_fornecedor(cp_cod_forn),
  cp_id_produto INT REFERENCES tbl_produto(cp_id_produto),
  PRIMARY KEY (cp_cod_forn, cp_id_produto)
);
