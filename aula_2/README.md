# 📚 Siglas em SQL: DDL, DML, DQL, DTL e DCL

No mundo dos bancos de dados relacionais, o **SQL (Structured Query Language)** é dividido em subconjuntos de comandos, cada um com um propósito específico.  
Esses subconjuntos são conhecidos pelas siglas: **DDL, DML, DQL, DTL e DCL**.

---

## 🔹 1. DDL – Data Definition Language (Linguagem de Definição de Dados)
Usada para **definir a estrutura do banco de dados**, como tabelas, índices e relações.

Exemplos de comandos:
- `CREATE` → cria tabelas, bancos de dados, índices, views.  
- `ALTER` → modifica tabelas ou colunas existentes.  
- `DROP` → exclui tabelas, bancos de dados ou objetos.  
- `TRUNCATE` → apaga todos os registros de uma tabela, mas mantém a estrutura.  

---

## 🔹 2. DML – Data Manipulation Language (Linguagem de Manipulação de Dados)
Responsável por **inserir, alterar e remover dados** dentro das tabelas.

Exemplos de comandos:
- `INSERT` → insere novos registros.  
- `UPDATE` → atualiza registros existentes.  
- `DELETE` → remove registros.  
- `MERGE` → insere ou atualiza dependendo da condição (suportado em alguns SGBDs).  

---

## 🔹 3. DQL – Data Query Language (Linguagem de Consulta de Dados)
Usada para **consultar dados** armazenados nas tabelas.  
Embora seja comum incluir o `SELECT` dentro de DML, alguns autores destacam DQL como categoria separada.

Exemplo:
- `SELECT` → consulta e retorna dados das tabelas.  

---

## 🔹 4. DCL – Data Control Language (Linguagem de Controle de Dados)
Responsável por **controlar permissões e segurança** no banco de dados.

Exemplos de comandos:
- `GRANT` → concede privilégios a usuários ou roles.  
- `REVOKE` → remove privilégios concedidos.  

---

## 🔹 5. DTL (ou TCL) – Data Transaction Language (Linguagem de Transação de Dados)
Usada para **gerenciar transações** dentro do banco, garantindo integridade e consistência.

Exemplos de comandos:
- `BEGIN` / `START TRANSACTION` → inicia uma transação.  
- `COMMIT` → confirma as alterações feitas.  
- `ROLLBACK` → desfaz as alterações caso haja erro.  
- `SAVEPOINT` → cria pontos de restauração dentro da transação.  

---

## 🚀 Resumindo
- **DDL** → estrutura (tabelas, colunas, índices).  
- **DML** → manipulação (inserir, atualizar, excluir dados).  
- **DQL** → consultas (`SELECT`).  
- **DCL** → permissões e segurança.  
- **DTL/TCL** → transações (commit, rollback).  

Essas divisões facilitam o entendimento da responsabilidade de cada comando SQL dentro do ciclo de vida de um banco de dados.

---
