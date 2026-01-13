#!/bin/bash  # Bash script interpreter
PORTAINER=https://localhost:9443  # Portainer URL
USER=admin  # Portainer username
PASS=password  # Portainer password

TOKEN=$(curl -s -X POST $PORTAINER/api/auth \  # Authenticate and get JWT token
  -H "Content-Type: application/json" \  # Set content type header
  -d "{\"Username\":\"$USER\",\"Password\":\"$PASS\"}" | jq -r .jwt)  # Extract JWT from response

ENDPOINT=$(curl -s -H "Authorization: Bearer $TOKEN" $PORTAINER/api/endpoints | jq -r '.[0].Id')  # Get first endpoint ID

curl -X POST "$PORTAINER/api/stacks?type=1&method=string&endpointId=$ENDPOINT" \  # Create stack via POST request
  -H "Authorization: Bearer $TOKEN" \  # Authorization header with token
  -F "Name=voting" \  # Stack name parameter
  -F "StackFileContent=@docker-compose.yml"  # Docker compose file content
