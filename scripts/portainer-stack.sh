#!/bin/bash
PORTAINER=https://localhost:9443
USER=admin
PASS=password

TOKEN=$(curl -s -X POST $PORTAINER/api/auth \
  -H "Content-Type: application/json" \
  -d "{\"Username\":\"$USER\",\"Password\":\"$PASS\"}" | jq -r .jwt)

ENDPOINT=$(curl -s -H "Authorization: Bearer $TOKEN" $PORTAINER/api/endpoints | jq -r '.[0].Id')

curl -X POST "$PORTAINER/api/stacks?type=1&method=string&endpointId=$ENDPOINT" \
  -H "Authorization: Bearer $TOKEN" \
  -F "Name=voting" \
  -F "StackFileContent=@docker-compose.yml"
