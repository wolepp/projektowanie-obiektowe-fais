# Singleton z bazą danych

Uruchomienie przez docker-compose

Aplikację można przetestować przez skrypt `test.sh`

__GET__  /dog/:id

__POST__ /dog
data: 
{
    "owner": "owner",
    "breed": "breed"
}

__PUT__ /dog
data:
{
    "id": 1,
    "owner": "owner",
    "breed": "breed"
}

__DELETE__ /dog/:id

