postgres:
	docker run --name postgres12 -p 6500:5432 -e POSTGRES_PASSWORD=password123 -d postgres:12-alpine
createdb:
	docker exec -it postgres12 createdb --username=postgres --owner=postgres simple_bank
dropdb:
	docker exec -it postgres12 dropdb --username=postgres simple_bank
migrateup:
	migrate -path db/migration -database "postgresql://postgres:password123@localhost:6500/simple_bank?sslmode=disable" -verbose up
migratedrop:
	migrate -path db/migration -database "postgresql://postgres:password123@localhost:6500/simple_bank?sslmode=disable" -verbose drop -f
migratedown:
	migrate -path db/migration -database "postgresql://postgres:password123@localhost:6500/simple_bank?sslmode=disable" -verbose down -all
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
.PHONY: postgres createdb dropdb migrateup migratedown migratedrop sqlc test
