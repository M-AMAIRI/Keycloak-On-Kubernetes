##################### Deploy Keycloak cluster locally #####################

# prerequisites
helm repo add bitnami https://charts.bitnami.com/bitnami
# when using minikube ingress addon ingress-nginx is already installed
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx -n ingress-nginx --create-namespace ingress-nginx/ingress-nginx



##################### Deploy the Keycloak cluster #########################
# create dedicated namespace for our deployments
kubectl create ns hotel
# create TLS cert
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout auth-tls.key -out auth-tls.crt -subj "/CN=auth.localtest.me/O=hotel"
kubectl create secret -n hotel tls auth-tls-secret --key auth-tls.key --cert auth-tls.crt
# deploy PostgreSQL cluster - in dev we will use 1 replica, in production use the default value of 3 (or set it to even a higher value)
helm install -n hotel keycloak-db bitnami/postgresql-ha --set postgresql.replicaCount=1
# deploy Keycloak cluster
kubectl apply -n hotel -f kc.yaml
# create HTTPS ingress for Keycloak
kubectl apply -n hotel -f keycloak-ingress.yaml





