const createTableUsuario = '''
CREATE TABLE Usuario(
id INTEGER NOT NULL PRIMARY KEY, 
nome VARCHAR(50) NOT NULL, 
email VARCHAR(150) NOT NULL,
usuario VARCHAR(10) NOT NULL,
senha VARCHAR(10) NOT NULL,
ativo INTEGER NOT NULL
);
''';

const createTableCliente = '''
CREATE TABLE Cliente(
id INTEGER NOT NULL PRIMARY KEY, 
usuarioId INT NOT NULL,
nome VARCHAR(50) NOT NULL, 
telefone CHAR(16) NOT NULL,
email VARCHAR(150) NOT NULL,
urlAvatar VARCHAR(300) NOT NULL,
dataCadastro VARCHAR(10) NOT NULL,
ativo INTEGER NOT NULL

);
''';

const createTableProduto = ''' 
CREATE TABLE Produto(
id INTEGER NOT NULL PRIMARY KEY,
usuarioId INTEGER NOT NULL,
codigoProduto VARCHAR(10) NOT NULL,
nome VARCHAR(50) NOT NULL, 
descricao VARCHAR(50) NULL,
valorCompra DOUBLE NOT NULL,
valorVendaPrevisao DOUBLE NOT NULL,
quantidade INTEGER NOT NULL,
dataCompra VARCHAR(10) NULL,
ativo INTEGER NOT NULL

);
''';

const createTableVenda = '''
CREATE TABLE Venda(
id INTEGER NOT NULL PRIMARY KEY,
usuarioId INTEGER NOT NULL,
saleOrder VARCHAR(10) NOT NULL,
clienteId INTEGER NOT NULL,
detail VARCHAR(50) NOT NULL,
valorTotalVenda DOUBLE NOT NULL,
dataVenda VARCHAR(10) NOT NULL,
ativo INTEGER NOT NULL
);
''';

const createTableVendaProduto = '''
CREATE TABLE VendaProduto(
id INTEGER NOT NULL PRIMARY KEY,
usuarioId INTEGER NOT NULL,
vendaId INTEGER NOT NULL,
produtoId INTEGER NOT NULL,
valorVenda DOUBLE NOT NULL,
quantidade INTEGER NOT NULL
);
''';
