CREATE TABLE IF NOT EXISTS Permissao (
    id SERIAL NOT NULL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS Usuario (
    id SERIAL NOT NULL PRIMARY KEY,
    senha CHAR(32) NOT NULL,
    login VARCHAR(250),
    nome VARCHAR(250),
    ativo BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS Setor (
    id SERIAL NOT NULL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS Cargo (
    id SERIAL NOT NULL PRIMARY KEY,
    salario REAL NOT NULL,
    nome VARCHAR(150) NOT NULL
);

CREATE TABLE IF NOT EXISTS Funcionario (
    id SERIAL NOT NULL PRIMARY KEY,
    setor_id INT NOT NULL,
    user_id INT NULL,
    cargo_id INT NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    nome VARCHAR(250) NOT NULL,
    CONSTRAINT FK_FUNCIONARIO_USER FOREIGN KEY (user_id) REFERENCES Usuario(id),
    CONSTRAINT FK_FUNCIONARIO_SETOR FOREIGN KEY (setor_id) REFERENCES Setor(id),
    CONSTRAINT FK_FUNCIONARIO_CARGO FOREIGN KEY (cargo_id) REFERENCES Cargo(id)
);

CREATE TABLE IF NOT EXISTS Projeto (
    id SERIAL NOT NULL PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    descricao VARCHAR(500) NOT NULL,
    data_inicio TIMESTAMP DEFAULT NOW(),
    data_final TIMESTAMP DEFAULT NOW()
);

CREATE TYPE status_enum as ENUM ('Pendente', 'Em Progresso', 'Concluido');

CREATE TABLE IF NOT EXISTS Tarefa (
    id SERIAL NOT NULL PRIMARY KEY,
    status status_enum not null,
    prazo TIMESTAMP NOT NULL,
    descricao VARCHAR(300) NOT NULL,
);

CREATE TABLE IF NOT EXISTS TarefaProjeto (
    tarefa_id INT NOT NULL,
    projeto_id INT NOT NULL,
    CONSTRAINT FK_TAREFAPROJETO_TAREFA FOREIGN KEY (tarefa_id) REFERENCES Tarefa(id),
    CONSTRAINT FK_TAREFAPROJETO_PROJETO FOREIGN KEY (projeto_id) REFERENCES Projeto(id)
);

CREATE TABLE IF NOT EXISTS FuncionarioProjeto (
    func_id INT NOT NULL,
    projeto_id INT NOT NULL,
    CONSTRAINT FK_FUNCIONARIOPROJETO_FUNC FOREIGN KEY (func_id) REFERENCES Funcionario(id),
    CONSTRAINT FK_FUNCIONARIOPROJETO_PROJETO FOREIGN KEY (projeto_id) REFERENCES Projeto(id)
);

CREATE TABLE IF NOT EXISTS SetorFuncionario (
    func_id INT NOT NULL,
    setor_id INT NOT NULL,
    CONSTRAINT FK_SETORFUNCIONARIO_FUNC FOREIGN KEY (func_id) REFERENCES Funcionario(id),
    CONSTRAINT FK_SETORFUNCIONARIO_SETOR FOREIGN KEY (setor_id) REFERENCES Setor(id)
);

CREATE TABLE IF NOT EXISTS PermissaoUsuario (
    user_id INT NOT NULL,
    permissao_id INT NOT NULL,
    CONSTRAINT FK_PERMISSAOUSUARIO_USER FOREIGN KEY (user_id) REFERENCES Usuario(id),
    CONSTRAINT FK_PERMISSAOUSUARIO_PERMISSAO FOREIGN KEY (permissao_id) REFERENCES Permissao(id)
);

CREATE TABLE IF NOT EXISTS FuncionarioTarefa (
    func_id INT NOT NULL,
    tarefa_id INT NOT NULL,
    CONSTRAINT FK_FUNCIONARIOTAREFA_FUNC FOREIGN KEY (func_id) REFERENCES Funcionario(id),
    CONSTRAINT FK_FUNCIONARIOTAREFA_TAREFA FOREIGN KEY (tarefa_id) REFERENCES Tarefa(id)
);