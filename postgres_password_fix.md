# 🐘 PostgreSQL 16 – Configuração de Senha no Usuário `postgres`

Este guia documenta o processo de corrigir uma instalação do **PostgreSQL 16 no Windows** onde o instalador **não pediu senha** e o usuário `postgres` não conseguia autenticar no **pgAdmin 4**.

---

## 📌 Problema
- O instalador não pediu senha para o usuário padrão `postgres`.  
- Tentativas de login no **pgAdmin 4** resultavam em erro de autenticação.  
- O arquivo `pg_hba.conf` estava configurado apenas para **`scram-sha-256`**, exigindo senha desde o início.  

---

## ✅ Solução Passo a Passo

### 1. Alterar configuração de autenticação
Edite o arquivo `pg_hba.conf` em:
```
C:\Program Files\PostgreSQL\16\data\pg_hba.conf
```

Troque as linhas de autenticação de `scram-sha-256` para `trust`:

```txt
# Antes
local   all             all                                     scram-sha-256
host    all             all             127.0.0.1/32            scram-sha-256
host    all             all             ::1/128                 scram-sha-256

# Depois (temporário)
local   all             all                                     trust
host    all             all             127.0.0.1/32            trust
host    all             all             ::1/128                 trust
```

---

### 2. Reiniciar o serviço
Abra `services.msc`, encontre **postgresql-x64-16** e clique em **Reiniciar**.

---

### 3. Entrar no psql sem senha
No **Prompt de Comando** ou **PowerShell**:

```powershell
"C:\Program Files\PostgreSQL\16\bin\psql.exe" -U postgres -h 127.0.0.1 -d postgres
```

Pressione **Enter** quando pedir a senha.  
Você deverá entrar direto no console (`postgres=#`).

---

### 4. Definir nova senha
Dentro do psql, rode:

```sql
ALTER USER postgres WITH PASSWORD 'Admin123!';
```

> Substitua `Admin123!` por uma senha forte de sua escolha.

Saia com:
```sql
\q
```

---

### 5. Restaurar configuração segura
Volte a editar o arquivo `pg_hba.conf` e restaure as linhas para exigir senha:

```txt
local   all             all                                     scram-sha-256
host    all             all             127.0.0.1/32            scram-sha-256
host    all             all             ::1/128                 scram-sha-256
```

---

### 6. Reiniciar novamente o serviço
Em `services.msc`, reinicie **postgresql-x64-16**.

---

### 7. Conectar no pgAdmin 4
No pgAdmin 4:
- **Host:** `127.0.0.1`
- **User:** `postgres`
- **Password:** a senha definida no passo 4  

Agora a conexão deve funcionar normalmente.

---

## 📎 Observações
- Se preferir compatibilidade maior (com Power BI, ferramentas antigas etc.), pode usar **`md5`** no lugar de `scram-sha-256`.  
- O método `scram-sha-256` é mais seguro e recomendado para produção.  
- Sempre reinicie o serviço PostgreSQL após editar o `pg_hba.conf`.

---

## 🚀 Resumo
1. Alterar `pg_hba.conf` para `trust`.  
2. Reiniciar serviço.  
3. Entrar no psql sem senha.  
4. Definir nova senha para `postgres`.  
5. Restaurar `pg_hba.conf` para `scram-sha-256` (ou `md5`).  
6. Reiniciar serviço.  
7. Conectar normalmente no pgAdmin.  

---
