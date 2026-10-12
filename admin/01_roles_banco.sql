-- ============================================================
-- OFICINA PostgreSQL — PIE IV
-- Arquivo: 01_roles_banco.sql
-- Descrição: Criação de roles e banco de dados
-- Executar como: postgres (superusuário da instalação)
-- ============================================================

-- ------------------------------------------------------------
-- PASSO 1: Criar as roles
-- ------------------------------------------------------------

-- Role de super administrador
CREATE ROLE admin_escola WITH
    LOGIN
    SUPERUSER
    PASSWORD 'Admin@2026';

-- Role de editor (leitura e escrita)
CREATE ROLE editor_escola WITH
    LOGIN
    PASSWORD 'Editor@2026';

-- Role de leitura (somente consulta)
CREATE ROLE leitor_escola WITH
    LOGIN
    PASSWORD 'Leitor@2026';

-- Verificar as roles criadas
-- \du

-- ------------------------------------------------------------
-- PASSO 2: Criar o banco de dados
-- ------------------------------------------------------------

CREATE DATABASE banco_escolar
    OWNER admin_escola
    ENCODING 'UTF8';

-- Verificar o banco criado
-- \l

-- ------------------------------------------------------------
-- PRÓXIMO PASSO:
-- Sair do psql e reconectar como admin_escola no banco_escolar:
--   \q
--   psql -U admin_escola -d banco_escolar
-- ------------------------------------------------------------
