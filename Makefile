start-keycloak:
	docker-compose -f docker-compose.yml up -d

stop-keycloak:
	docker-compose -f docker-compose.yml down
