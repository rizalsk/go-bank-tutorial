package db

import (
	"database/sql"
	"log"
	"os"
	"testing"

	_ "github.com/lib/pq"
)

const (
	dbDriver = "postgres"
	dbSource = "postgresql://postgres:password123@localhost:6500/simple_bank?sslmode=disable"
)

// ref : #a
var testQueries *Queries
var testDB *sql.DB

func TestMain(m *testing.M) {
	/*
		## ref: #a
		conn, err := sql.Open(dbDriver, dbSource)
		if err != nil {
			log.Fatal("Could not connect db", err)
		}

		testQueries = New(conn)
	*/

	var err error
	testDB, err = sql.Open(dbDriver, dbSource)
	if err != nil {
		log.Fatal("Could not connect to dataase")
	}

	testQueries = New(testDB)
	os.Exit(m.Run())
}
