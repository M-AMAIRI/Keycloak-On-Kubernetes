
create a separate database and add the information for database in your deployment.yaml file in form of env variable. In my case I have deployed the pod for postgressql, I have created a nodePort service for postgressql pod. Below are the env variables you need to add in deployment.yaml of Keycloak to resolve data lost issue. Here “DB_ADDR” is hostname of postgress,

-
                name: "DB_VENDOR"
                value: "POSTGRES"
                
              -
                name: "DB_ADDR"
                value: "xxxx"
                
              -
                name: "DB_PORT"
                value: "xxxx"
                
              -
                name: "DB_DATABASE"
                value: "keycloak"
                
              -
                name: "DB_USER"
                value: "postgres"
                
              -
                name: "DB_PASSWORD"
                value: "xxxx"
                
 
           env:
            - name: KEYCLOAK_ADMIN
              value: "admin"
            - name: KEYCLOAK_ADMIN_PASSWORD
              value: "admin"
            - name: KC_HTTPS_CERTIFICATE_FILE
              value: "/etc/certs/tls.crt"
            - name: KC_HTTPS_CERTIFICATE_KEY_FILE
              value: "/etc/certs/tls.key"
            - name: KC_HEALTH_ENABLED
              value: "true"
            - name: KC_METRICS_ENABLED
              value: "true"
            - name: KC_HOSTNAME
              value: auth.localtest.me
            - name: KC_PROXY
              value: "edge"
            - name: KC_DB
              value: postgres
            - name: KC_DB_URL
              value: "jdbc:postgresql://keycloak-db-postgresql-ha-pgpool/postgres"
            - name: KC_DB_USERNAME
              value: "postgres"
            - name: KC_DB_PASSWORD
              value: "xxxx"
            - name: jgroups.dns.query
              value: keycloak
              
