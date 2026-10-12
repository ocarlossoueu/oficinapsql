# 🐘 Oficina PostgreSQL — Criando um Banco de Dados do Zero

> Material completo da Oficina de Introdução a Banco de Dados com PostgreSQL — PIE IV  
> Universidade Federal de Rondonópolis (UFR) — Projetos Integrados de Extensão  
> Turma: ETEC — Desenvolvimento de Sistemas

---

## 📋 Sobre esta oficina

Esta oficina tem duração de **2 horas** e é voltada para **iniciantes completos** em banco de dados. O objetivo é construir, do absoluto zero, um ambiente PostgreSQL completo: criando roles, banco de dados, tabelas com relacionamentos e aplicando permissões por perfil de usuário.

Ao final, o banco criado aqui é utilizado na **Oficina de SQL (PIE V)**, onde os mesmos dados são explorados com consultas progressivas usando `SELECT`, `JOIN`, `GROUP BY` e CTEs.

### O que você vai aprender

- O que é um servidor PostgreSQL e como ele se organiza
- Como criar e gerenciar **roles** (usuários e grupos de acesso)
- Como criar um **banco de dados** e definir seu proprietário
- Como criar **tabelas** com tipos de dados, chaves primárias e chaves estrangeiras
- Como aplicar **permissões** granulares por role (somente leitura, leitura/escrita, superusuário)
- Como popular as tabelas com dados reais

---

## 🛠 Pré-requisitos

- **PostgreSQL 17** instalado no Windows  
  Download: [postgresql.org/download/windows](https://www.postgresql.org/download/windows/)
- **psql** no PATH do sistema (veja a seção de configuração abaixo)
- **DBeaver** instalado (usado na Oficina de SQL — PIE V)  
  Download: [dbeaver.io](https://dbeaver.io/download/)

### Configurando o PATH do psql no Windows

Após instalar o PostgreSQL, o comando `psql` pode não ser reconhecido no CMD. Para corrigir:

1. Tecla Windows → buscar **"Variáveis de ambiente"** → abrir
2. Em **Variáveis do sistema**, localizar `Path` → clicar em **Editar**
3. Clicar em **Novo** e adicionar:
   ```
   C:\Program Files\PostgreSQL\17\bin
   ```
4. Confirmar com OK em todas as janelas
5. **Fechar e reabrir o CMD** — agora o `psql` será reconhecido

### Verificando se o serviço está rodando

Abra o CMD e execute:

```cmd
sc query postgresql-x64-17
```

Se o estado for `RUNNING`, está pronto. Se estiver `STOPPED`:

```cmd
net start postgresql-x64-17
```

> ⚠️ Para iniciar/parar o serviço, o CMD deve ser aberto **como administrador**.

---

## 📁 Estrutura do repositório

```
oficinapsql/
│
├── README.md                        ← este arquivo
│
├── admin/
│   └── 01_roles_banco.sql           ← criação de roles e banco de dados
│
├── tabelas/
│   └── 02_create_tables.sql         ← criação das 9 tabelas com FKs
│
├── permissoes/
│   └── 03_grant.sql                 ← concessão de privilégios por role
│
├── dados/
│   └── 04_inserts.sql               ← população completa (960 registros)
│
└── apostila/
    ├── apostila_professor.pdf        ← guia de acompanhamento em sala
    └── apostila_aluno.pdf            ← material autocontido para estudo
```

---

## 🚀 Ordem de execução

Execute os scripts **nesta ordem**, respeitando o usuário indicado em cada um:

| # | Arquivo | Conectar como | Banco |
|---|---------|--------------|-------|
| 1 | `admin/01_roles_banco.sql` | `postgres` | `postgres` (padrão) |
| 2 | `tabelas/02_create_tables.sql` | `admin_escola` | `banco_escolar` |
| 3 | `permissoes/03_grant.sql` | `admin_escola` | `banco_escolar` |
| 4 | `dados/04_inserts.sql` | `admin_escola` | `banco_escolar` |

### Como executar via CMD

**Passo 1 — Conectar como postgres e criar roles/banco:**
```cmd
psql -U postgres
```
Cole o conteúdo de `01_roles_banco.sql` e pressione Enter.

**Passo 2 — Sair e reconectar como admin_escola:**
```sql
\q
```
```cmd
psql -U admin_escola -d banco_escolar
```

**Passos 3 e 4 — Executar dentro do banco_escolar:**  
Cole o conteúdo de `02_create_tables.sql`, depois `03_grant.sql` e por fim `04_inserts.sql`.

---

## 🗂 Modelo de dados — Banco Escolar

O banco simula um sistema acadêmico com 4 turmas, 20 alunos, 6 matérias e dados de notas e presenças ao longo de 4 semestres (2024/1 a 2025/2).

```
especialidades
    └── professores
            └── turmas
                    └── alunos
                            ├── matriculas
                            ├── notas ──── tipos_notas
                            └── presencas

materias ──── notas
         └── presencas
```

### Tabelas

| Tabela | Tipo | Descrição |
|--------|------|-----------|
| `especialidades` | Dimensão | Áreas de especialidade dos professores |
| `professores` | Dimensão | Dados dos professores |
| `turmas` | Dimensão | Turmas por ano/semestre |
| `materias` | Dimensão | Matérias e carga horária |
| `tipos_notas` | Dimensão | Tipos de avaliação (Prova 1, Prova 2, Trabalho) |
| `alunos` | Fato | Alunos vinculados a turmas |
| `matriculas` | Relacionamento | Matrícula de aluno em turma |
| `notas` | Fato | Notas por aluno, matéria e tipo |
| `presencas` | Fato | Registro de presença por aula |

### Volume de dados

| Tabela | Registros |
|--------|-----------|
| especialidades | 5 |
| professores | 8 |
| turmas | 4 |
| materias | 6 |
| tipos_notas | 3 |
| alunos | 20 |
| matriculas | 60 |
| notas | 240 |
| presencas | 960 |

---

## 👥 Roles criadas

| Role | Tipo | Permissões |
|------|------|-----------|
| `admin_escola` | Superusuário | Controle total do banco |
| `editor_escola` | Usuário comum | SELECT, INSERT, UPDATE, DELETE em todas as tabelas |
| `leitor_escola` | Usuário comum | Somente SELECT |

---

## 📖 Cheat sheet — Comandos psql

| Comando | Função |
|---------|--------|
| `\l` | Listar bancos de dados |
| `\du` | Listar roles |
| `\dt` | Listar tabelas |
| `\conninfo` | Exibir conexão atual |
| `\c nome_banco` | Trocar de banco |
| `\q` | Sair do psql |
| `\?` | Ajuda dos comandos psql |
| `\h COMANDO` | Ajuda de sintaxe SQL |

---

## 🔗 Continuação — Oficina de SQL (PIE V)

Após esta oficina, o banco criado aqui é utilizado na **Oficina de SQL**, onde você aprenderá a consultar e analisar os dados com:

- `SELECT`, `WHERE`, `ORDER BY`, `LIMIT`
- `GROUP BY`, `HAVING` e funções de agregação
- `INNER JOIN`, `LEFT JOIN`, `FULL OUTER JOIN`
- CTEs (`WITH`) para consultas avançadas

Repositório da Oficina de SQL: [github.com/ocarlossoueu/oficinasql](https://github.com/ocarlossoueu/oficinasql)

---

## 👨‍🏫 Autor

**Carlos Amarijo**  
Engenheiro de Dados | Discente de Sistemas de Informação — UFR  
[linkedin.com/in/ocarlossoueu](https://linkedin.com/in/ocarlossoueu)

---

> Material desenvolvido para fins educacionais no âmbito dos Projetos Integrados de Extensão (PIE) da UFR.  
> Uso livre para fins de estudo e ensino.
