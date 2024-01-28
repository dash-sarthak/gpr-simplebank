postgres:
	podman run --name postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:latest
createdb:
	podman exec -it postgres createdb --username=root --owner=root simple_bank
dropdb:
	podman exec -it postgres dropdb simple_bank
migrateup:
	migrate --path db/schema --database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" --verbose up
migratedown:
	migrate --path db/schema --database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" --verbose down
sqlc:
	sqlc generate

.PHONY: createdb dropdb migrateup migratedown