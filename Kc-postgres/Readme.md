## deploy Keycloak + Postgress Connection
create a separate database and add the information for database in your deployment.yaml file in form of env variable. In my case I have deployed the pod for postgressql, I have created a nodePort service for postgressql pod. Below are the env variables you need to add in deployment.yaml of Keycloak to resolve data lost issue. Here “DB_ADDR” is hostname of postgress,

Using these settings worked for me (using MariaBD):

KC_DB: postgres

KC_DB_URL: jdbc:postgresql://Ip-keycloak-db-postgresql/postgres

KC_DB_USERNAME: keycloak

KC_DB_PASSWORD: your-password

sh'''
kubectl create -f keycloak.yaml

wget -q -O - keycloak-ingress.yaml |
sed "s/KEYCLOAK_HOST/$(kubectl get service/keycloak -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" |
kubectl create -f -

KEYCLOAK_URL=https://$(kubectl get service/keycloak -o jsonpath='{.status.loadBalancer.ingress[0].ip}') && echo "" && echo "Keycloak: $KEYCLOAK_URL" && echo "Keycloak Admin Console: $KEYCLOAK_URL/admin" && echo "Keycloak Account Console: $KEYCLOAK_URL/realms/myrealm/account" && echo ""

kubectl get service/keycloak -o jsonpath='{.status.loadBalancer.ingress[0].ip}'

echo http://$(kubectl get service/keycloak -o jsonpath='{.status.loadBalancer.ingress[0].ip}'):8080
'''

## deploy and Test Postgres 

kubectl create -f Postgres.yaml

### Test Postgres 

sh'''

kubectl exec -it podname --  psql -h localhost -U admin --password -p 5432 postgresdb

'''













