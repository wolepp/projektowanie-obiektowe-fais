package dbconnector

import (
	"database/sql"
	"fmt"
	_ "github.com/mattn/go-sqlite3"
)

type Dbconnector struct {
	db *sql.DB
}

var connector *Dbconnector

func GetInstance() *Dbconnector {
	if connector == nil {
		connector = &Dbconnector{}
		connector.Init()
	}
	return connector
}

func (c *Dbconnector) Init() {
	db, err := sql.Open("sqlite3", "./data.db")

	if err != nil {
		fmt.Println("Cannot open database")
	}

	_, err = db.Exec("CREATE TABLE IF NOT EXISTS dogs (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, owner TEXT NOT NULL, breed TEXT NOT NULL)")
	if err != nil {
		fmt.Println("Cannot create database")
	}

	connector.db = db
}

func (c *Dbconnector) Search(query string) (*sql.Rows, error) {
	rows, err := c.db.Query(query)
	if err != nil {
		return nil, err
	}
	return rows, err
}

func (c *Dbconnector) Query(query string) (int64, error) {
	statement, err := c.db.Prepare(query)
	if err != nil {
		return -1, err
	}

	res, err := statement.Exec()
	if err != nil {
		return -1, err
	}

	id, err := res.LastInsertId()
	if err != nil {
		return -1, err
	}

	return id, nil
}

func (c *Dbconnector) Stop() {
	if err := c.db.Close(); err != nil {
		fmt.Println("Cannot close database")
	}
}
