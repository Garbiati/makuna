const createTableCliente = '''
CREATE TABLE Cliente(
id INTEGER NOT NULL PRIMARY KEY, 
nome VARCHAR(50) NOT NULL, 
telefone CHAR(16) NOT NULL,
email VARCHAR(150) NULL,
urlAvatar VARCHAR(300) NOT NULL,
dataCadastro VARCHAR(10) NOT NULL
);
''';

const createTableProduto = ''' 
CREATE TABLE Produto(
id INTEGER NOT NULL PRIMARY KEY,
nome VARCHAR(50) NOT NULL, 
descricao VARCHAR(50) NULL, 
dataCompra VARCHAR(10) NULL,
valorCompra DOUBLE NOT NULL,
valorVendaPrevisao DOUBLE NOT NULL
);     
''';

const createTableVenda = '''
CREATE TABLE Venda(
id INTEGER NOT NULL PRIMARY KEY,
clienteId INT NOT NULL,
produtoId INT NOT NULL,
valorVenda DOUBLE NOT NULL,
detail VARCHAR(50),
dataVenda VARCHAR(10) NOT NULL
);
''';
