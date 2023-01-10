kubectl create -f keycloak.yaml

wget -q -O - keycloak-ingress.yaml |
sed "s/KEYCLOAK_HOST/$(kubectl get service/keycloak -o jsonpath='{.status.loadBalancer.ingress[0].ip}')" |
kubectl create -f -

KEYCLOAK_URL=https://$(kubectl get service/keycloak -o jsonpath='{.status.loadBalancer.ingress[0].ip}') && echo "" && echo "Keycloak: $KEYCLOAK_URL" && echo "Keycloak Admin Console: $KEYCLOAK_URL/admin" && echo "Keycloak Account Console: $KEYCLOAK_URL/realms/myrealm/account" && echo ""

kubectl get service/exservice -o jsonpath='{.status.loadBalancer.ingress[0].ip}'

echo http://$(kubectl get service/keycloak -o jsonpath='{.status.loadBalancer.ingress[0].ip}'):8080
