:- use_module('postgresql-prolog/postgresql').

main :-
    postgresql:connect("postgres", "secret", '127.0.0.1', 5432, "pgvector_prolog_test", Connection),
    postgresql:query(Connection, "CREATE EXTENSION IF NOT EXISTS vector", ok),
    postgresql:query(Connection, "DROP TABLE IF EXISTS items", ok),
    postgresql:query(Connection, "CREATE TABLE items (id bigserial PRIMARY KEY, embedding vector(3))", ok),
    postgresql:sql(Connection, [insert_into(items, [embedding]), values("[1,2,3]")], data([])),
    postgresql:sql(Connection, [insert_into(items, [embedding]), values("[4,5,6]")], data([])),
    postgresql:query(Connection, "SELECT * FROM items ORDER BY embedding <-> '[3,1,2]' LIMIT 5", Rows),
    write(Rows),
    nl.
