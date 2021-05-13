# Autoryzacja w Kotlin

Uruchomienie przez docker-compose. Uruchomienie trwa dosyć długo przez budowanie projektu.

## Endpointy:

- POST /authorize/register
- GET /authorize/login
- GET /authorize/logout
	
## Przykładowa obsługa

Rejestracja 

```shell
curl -XPOST 'localhost:58080/authorize/register' \
  -H 'Content-Type: application/json' \
  -d '{
    "nickname": "bestUserEver",
    "password": "admin123"
  }'
```

Logowanie

```shell
curl -XGET -G 'localhost:58080/authorize/login' \
  -d nickname=bestUserEver \
  -d password=admin123
```

Wylogowanie

```shell
curl -XGET -G 'localhost:58080/authorize/logout' \
  -d nickname=bestUserEver
```
