const createTableCliente = '''
CREATE TABLE Cliente(
  id INTEGER NOT NULL PRIMARY KEY, 
  nome VARCHAR(200) NOT NULL, 
  telefone CHAR(16) NOT NULL,
  email VARCHAR(150) NULL,
  urlAvatar VARCHAR(300) NOT NULL,
  dataCadastro NOT NULL
  )
''';
