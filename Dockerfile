FROM registry:2

ENV REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt REGISTRY_HTTP_TLS_KEY=/certs/domain.key
ENV REGISTRY_AUTH=htpasswd REGISTRY_AUTH_HTPASSWD_REALM=Registry REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd

COPY certs /certs
COPY auth /auth
