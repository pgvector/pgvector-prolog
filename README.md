# pgvector-prolog

[pgvector](https://github.com/pgvector/pgvector) examples for Prolog

Supports [postgresql-prolog](https://github.com/aarroyoc/postgresql-prolog)

[![Build Status](https://github.com/pgvector/pgvector-prolog/actions/workflows/build.yml/badge.svg)](https://github.com/pgvector/pgvector-prolog/actions)

## Getting Started

Follow the instructions for your database library:

- [postgresql-prolog](#postgresql-prolog)

## postgresql-prolog

Enable the extension

```prolog
postgresql:query(Connection, "CREATE EXTENSION IF NOT EXISTS vector", ok)
```

Create a table

```prolog
postgresql:query(Connection, "CREATE TABLE items (id bigserial PRIMARY KEY, embedding vector(3))", ok)
```

Insert vectors

```prolog
postgresql:sql(Connection, [insert_into(items, [embedding]), values("[1,2,3]")], data([]))
```

Get the nearest neighbors

```prolog
postgresql:query(Connection, "SELECT * FROM items ORDER BY embedding <-> '[3,1,2]' LIMIT 5", Rows)
```

Add an approximate index

```prolog
postgresql:query(Connection, "CREATE INDEX ON items USING hnsw (embedding vector_l2_ops)", ok)
```

Use `vector_ip_ops` for inner product and `vector_cosine_ops` for cosine distance

See a [full example](example.pl)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/pgvector/pgvector-prolog/issues)
- Fix bugs and [submit pull requests](https://github.com/pgvector/pgvector-prolog/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development:

```sh
git clone https://github.com/pgvector/pgvector-prolog.git
cd pgvector-prolog
createdb pgvector_prolog_test
scryer-prolog example.pl -g "main,halt."
```
