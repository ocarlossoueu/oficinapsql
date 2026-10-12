-- ============================================================
-- OFICINA PostgreSQL — PIE IV
-- Arquivo: 02_create_tables.sql
-- Descrição: Criação das tabelas do Banco Escolar
-- Executar como: admin_escola no banco banco_escolar
-- Pré-requisito: executar 01_roles_banco.sql antes
-- ============================================================

-- ------------------------------------------------------------
-- DIMENSÕES (sem dependências externas — criar primeiro)
-- ------------------------------------------------------------

-- 1. Especialidades dos professores
CREATE TABLE especialidades (
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL
);

-- 2. Professores
CREATE TABLE professores (
    id               SERIAL PRIMARY KEY,
    nome             VARCHAR(100) NOT NULL,
    email            VARCHAR(100) NOT NULL,
    especialidade_id INT NOT NULL REFERENCES especialidades(id)
);

-- 3. Turmas
CREATE TABLE turmas (
    id           SERIAL PRIMARY KEY,
    nome         VARCHAR(50) NOT NULL,
    ano          INT NOT NULL,
    semestre     INT NOT NULL,
    professor_id INT NOT NULL REFERENCES professores(id)
);

-- 4. Matérias
CREATE TABLE materias (
    id            SERIAL PRIMARY KEY,
    nome          VARCHAR(100) NOT NULL,
    carga_horaria INT NOT NULL DEFAULT 64
);

-- 5. Tipos de Notas
CREATE TABLE tipos_notas (
    id   SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL
);

-- ------------------------------------------------------------
-- FATOS / RELACIONAMENTOS (dependem das dimensões acima)
-- ------------------------------------------------------------

-- 6. Alunos
CREATE TABLE alunos (
    id              SERIAL PRIMARY KEY,
    nome            VARCHAR(100) NOT NULL,
    email           VARCHAR(100) NOT NULL,
    data_nascimento DATE,
    turma_id        INT NOT NULL REFERENCES turmas(id)
);

-- 7. Matrículas
CREATE TABLE matriculas (
    id             SERIAL PRIMARY KEY,
    aluno_id       INT NOT NULL REFERENCES alunos(id),
    turma_id       INT NOT NULL REFERENCES turmas(id),
    data_matricula DATE NOT NULL
);

-- 8. Notas
CREATE TABLE notas (
    id         SERIAL PRIMARY KEY,
    aluno_id   INT NOT NULL REFERENCES alunos(id),
    materia_id INT NOT NULL REFERENCES materias(id),
    nota       FLOAT NOT NULL,
    tipo_id    INT NOT NULL REFERENCES tipos_notas(id)
);

-- 9. Presenças
CREATE TABLE presencas (
    id          SERIAL PRIMARY KEY,
    aluno_id    INT NOT NULL REFERENCES alunos(id),
    materia_id  INT NOT NULL REFERENCES materias(id),
    data_aula   DATE NOT NULL,
    presente    BOOLEAN NOT NULL,
    justificada BOOLEAN
);

-- Verificar tabelas criadas
-- \dt
