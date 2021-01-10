# About
- Basic lambda application.
- Jenkinsfile for multiple environments e multiple accounts support.
- Serverless for deploy in AWS.


## For test
```
curl --request GET \
  --url <API_URL>/<ENV_NAME>/hello/world
```

```
curl --request POST \
  --url <API_URL>/<ENV_NAME>/hello/message \
  --header 'Content-Type: application/json' \
  --data '{
	"message": "<TYPE_SOME_MESSAGE>"
}'
```
