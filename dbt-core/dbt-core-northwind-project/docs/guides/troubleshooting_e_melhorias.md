# Guia de Troubleshooting e Melhorias no Ambiente dbt

Este documento consolida os principais problemas encontrados ao rodar o projeto localmente com Docker e dbt-core e o passo a passo de como eles foram solucionados. 

## 1. Erro de Variáveis de Ambiente no `profiles.yml`

**Sintoma:** Ao executar `dbt debug`, o dbt falhava logo na análise do arquivo de conexões reportando:
```text
Parsing Error
  Env var required but not provided: 'DB_HOST_PROD'
```

**Causa:** O arquivo `profiles.yml` estava configurado inicialmente para apontar apenas para um target `prod` que buscava parâmetros de configuração dinamicamente a partir de variáveis de ambiente. Como elas não estavam carregadas no terminal local/WSL, a validação falhava.

**Solução Aplicada:**
Editamos o `profiles.yml` para criar um ambiente de desenvolvimento `dev`, apontando para os serviços internos do `docker-compose`. Foi feito o preenchimento manual dos dados, visto que ambos (banco e dbt) rodam na mesma rede docker.
```yaml
northwind:
  target: dev
  outputs:
    dev:
      type: postgres
      host: db
      user: northwind
      password: northwind
      port: 5432
      dbname: northwind
      schema: public
      threads: 4
```

---

## 2. Erro "Project loading failed" (dbt_project.yml not found)

**Sintoma:** Após conectar no banco perfeitamente, o `dbt debug` e demais comandos começaram a retornar o seguinte erro:
```text
Project loading failed for the following reason:
 project path </usr/app/dbt-core-northwind-project/dbt_project.yml> not found
```

**Causa:** O diretório alvo padrão para os comandos dbt dentro do container apontava para `/usr/app/dbt-core-northwind-project`, porém os arquivos e o `dbt_project.yml` ficam na pasta `/usr/app/northwind` em virtude da arquitetura dos diretórios atrelados aos volumes mapeados (`/:/usr/app`).

**Solução Aplicada:**
Alteramos o ponto de montagem de ambiente de trabalho no `docker-compose.yml` para o worker do dbt (`dbt-core`). Editamos a linha `working_dir` e reiniciamos os containers.
```yaml
# docker-compose.yml - Serviço: dbt-core
working_dir: /usr/app/northwind
```

---

## 3. Erro de ausência de tabelas no banco de dados

**Sintoma:** O banco estava conectando com o dbt, porém, durante a execução de `dbt run`, diversos erros de banco de dados surgiram:
```text
Database Error in model raw_orders (models/raw/raw_orders.sql)
relation "orders" does not exist
```

**Causa:** O comando `docker compose up` construiu os containers e o volume de dados vazios. O PostgreSQL iniciou sem as tabelas do sistema Northwind originais. Uma vez que o dbt é a camada responsável estritamente por transformação, ele requer que os dados crus (tabelas base) já existam.

**Solução Aplicada:**
Fizemos a importação (seed / dataload) do script `northwind.sql` – que contém os scripts "CREATE TABLE" e "INSERT" globais – mandando-o diretamente para o client psql no container do banco de dados operacional.
```bash
docker exec -i northwind-db psql -U northwind -d northwind < northwind.sql
```

**Resultado:** A importação criou as categorias, clientes, pedidos e afins. Em seguida, a execução do pipeline de dados ocorreu sem percalços:
1. `dbt run`: Compilou e executou as 8 views na camada staging e raw e depois gerou materializações de 8 modelos agregados e de relatórios na camada `public_gold`.
2. `dbt test`: Todos os 11 testes predefinidos para garantir a qualidade de chaves e de campos _not_null_ rodaram com sucesso. O ambiente local ficou totalmente operacional!
