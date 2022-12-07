const createTableCliente = '''
CREATE TABLE Cliente(
  id INTEGER NOT NULL PRIMARY KEY, 
  nome VARCHAR(50) NOT NULL, 
  telefone CHAR(16) NOT NULL,
  email VARCHAR(150) NULL,
  urlAvatar VARCHAR(300) NOT NULL,
  dataCadastro VARCHAR(50) NOT NULL
  )
''';

const createTableProduto = '''
"CREATE TABLE Produto(
  id INTEGER NOT NULL PRIMARY KEY,
  nome VARCHAR(50) NOT NULL, 
  descricao VARCHAR(50),
  dataCompra VARCHAR(50),
  valorCompra DOUBLE NOT NULL,
  valorVendaPrevisao DOUBLE NOT NULL)"
''';
