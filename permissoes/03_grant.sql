-- ============================================================
-- OFICINA PostgreSQL — PIE IV
-- Arquivo: 03_grant.sql
-- Descrição: Concessão de privilégios por role
-- Executar como: admin_escola no banco banco_escolar
-- Pré-requisito: executar 01 e 02 antes
-- ============================================================

-- ------------------------------------------------------------
-- ROLE: editor_escola — leitura e escrita completas
-- ------------------------------------------------------------

GRANT CONNECT ON DATABASE banco_escolar TO editor_escola;
GRANT USAGE ON SCHEMA public TO editor_escola;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO editor_escola;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO editor_escola;

-- ------------------------------------------------------------
-- ROLE: leitor_escola — somente leitura
-- ------------------------------------------------------------

GRANT CONNECT ON DATABASE banco_escolar TO leitor_escola;
GRANT USAGE ON SCHEMA public TO leitor_escola;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO leitor_escola;

-- ------------------------------------------------------------
-- TESTE SUGERIDO:
-- Conectar como leitor e tentar um INSERT — deve dar erro:
--   psql -U leitor_escola -d banco_escolar
--   INSERT INTO especialidades (nome) VALUES ('Teste');
--   -- esperado: ERROR: permission denied for table especialidades
-- ------------------------------------------------------------
