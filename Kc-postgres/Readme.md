
create a separate database and add the information for database in your deployment.yaml file in form of env variable. In my case I have deployed the pod for postgressql, I have created a nodePort service for postgressql pod. Below are the env variables you need to add in deployment.yaml of Keycloak to resolve data lost issue. Here “DB_ADDR” is hostname of postgress,

Using these settings worked for me (using MariaBD):
KC_DB: postgres
KC_DB_URL: jdbc:postgresql://keycloak-db-postgresql-ha-pgpool/postgres
KC_DB_USERNAME: keycloak
KC_DB_PASSWORD: your-password

