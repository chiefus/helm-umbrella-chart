global:
  storageClass: bahmni-efs-sc
  nodeSelector:
    eks.amazonaws.com/nodegroup: NODEGROUP_NAME
  TZ: "Asia/Kolkata"

metadata:
  labels:
    environment: TENANT_NAME
  ingress:
    PROXY_BODY_SIZE: "7m"
    ABDM_PROXY_BODY_SIZE: "30m"

openmrs:
  enabled: true
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/infoiplitin/openmrs
    tag: iplit-1.0.0-639-5

bahmni-web:
  enabled: true
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/infoiplitin/bahmni-iplit-web
    tag: 1.0.0-85

bahmni-lab:
  enabled: true
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/bahmni/bahmni-lab
    tag: 1.1.0-171

crater:
  enabled: true
  metadata:
    labels:
      environment: TENANT_NAME
  config:
    AUTO_INSTALL: "true"
    ADMIN_NAME: Super Man
    COMPANY_NAME: Bahmni
    COMPANY_SLUG: bahmni
    COUNTRY_ID: 101
  secrets:
    ADMIN_EMAIL: "superman@bahmni.org"
  image:
    nginx:
      repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
      name: bahmnilite/bahmni/crater-nginx
      tag: 1.1.0-218
    php:
      repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
      name: bahmnilite/bahmni/crater-php
      tag: 1.1.0-105

reports:
  enabled: true
  metadata:
    labels:
      environment: TENANT_NAME
  config:
    OPENMRS_HOST: "openmrs"
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/bahmni/reports
    tag: 1.1.0-142

hiu:
  enabled: true
  config:
    POSTGRES_HOST: "bahmni-TENANT_NAME-postgresql"
    RABBITMQ_HOST: "bahmni-TENANT_NAME-rabbitmq"
    HIU_ID: "TENANT_NAME"
    HIU_NAME: "TENANT_NAME"
    CONSENT_MANAGEMENT_SUFFIX: "@sbx"
    CONSENT_MANAGEMENT_URL: "https://live.ndhm.gov.in/cm"
    GATEWAY_BASE_URL: "https://dev.abdm.gov.in/gateway/v0.5"
    GATEWAY_JWK_URL: "https://dev.abdm.gov.in/gateway/v0.5/certs"
    HFR_AFFINITY_DOMAINS: "facilitysbx.ndhm.gov.in"
    IDENTITY_JWK_URL : "https://dev.ndhm.gov.in/auth/realms/consent-manager/protocol/openid-connect/certs"
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/infoiplitin/hiu
    tag: 1.0.0-29

hiu-db:
  enabled: true
  config:
    JAVA_TOOL_OPTIONS: "-Djdbc.url=jdbc:postgresql://bahmni-TENANT_NAME-postgresql:5432/ -Djdbc.username=postgres -Djdbc.password=welcome -Djdbc.database=health_information_user"
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/bahmniindiadistro/hiu-db
    tag: 1.0.0-74

hiu-ui:
  enabled: true
  config:
    POSTGRES_HOST: bahmni-TENANT_NAME-postgresql
    RABBITMQ_HOST: bahmni-TENANT_NAME-rabbitmq
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/infoiplitin/hiu-ui
    tag: 1.0.0-9

hip:
  enabled: true
  config:
    CONNECTION_STRING: "Host=bahmni-TENANT_NAME-postgresql;Port=5432;Username=postgres;Password=welcome;Database=hipservice"
    RABBITMQ_HOST: "bahmni-TENANT_NAME-rabbitmq"
    BAHMNI_ID: "TENANT_NAME"
    BAHMNI_URL: http://openmrs:8080/openmrs
    GATEWAY_URL: "https://dev.abdm.gov.in/gateway"
    GATEWAY_CMSUFFIX: "sbx"
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/infoiplitin/hip
    tag: 1.0.0-147

otp-service:
  enabled: true
  config:
    CONNECTION_STRING: "Host=bahmni-TENANT_NAME-postgresql;Port=5432;Username=postgres;Password=welcome;Database=otpservice;"
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/infoiplitin/otp-service
    tag: 1.0.0-12

hip-atomfeed:
  enabled: true
  config:
    DATABASE_URL: "jdbc:postgresql://bahmni-TENANT_NAME-postgresql:5432/"
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/bahmniindiadistro/hip-atomfeed
    tag: 1.0.0-109

postgresql:
  enabled: true
  volumePermissions:
    enabled: true
    image:
      registry: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
      repository: bitnami-shell
      tag: 11-debian-11-r50
  primary:
    persistence:
      subPath: TENANT_NAME
      storageClass: bahmni-efs-sc
      accessModes:
        - ReadWriteMany
    nodeSelector:
      eks.amazonaws.com/nodegroup: NODEGROUP_NAME
  image:
    registry: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    repository: postgresql
    tag: 14-debian-11

rabbitmq:
  enabled: true
  auth:
    securePassword: false
    erlangCookie: bahmni
  persistence:
    storageClass: bahmni-efs-sc
    accessModes:
      - ReadWriteMany
  nodeSelector:
    eks.amazonaws.com/nodegroup: NODEGROUP_NAME
  image:
    repository: rabbitmq
    tag: alpine

patient-documents:
  enabled: true
  metadata:
    labels:
      environment: TENANT_NAME
  config:
    OPENMRS_HOST: "openmrs"
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/bahmni/patient-documents
    tag: 1.1.0-29

appointments:
  enabled: true
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/bahmni/appointments
    tag: 1.1.0-95

crater-atomfeed:
  enabled: true
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/bahmni/crater-atomfeed
    tag: 1.1.0-125

implementer-interface:
  enabled: true
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/bahmni/implementer-interface
    tag: 1.1.0-67

clinic-config:
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/infoiplitin/clinic-config-indiadistro
    tag: 1.0.0-26

abha-verification:
  enabled: true
  metadata:
    labels:
      environment: TENANT_NAME
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/infoiplitin/abha-verification
    tag: 1.0.0-3

bahmni-metabase:
  enabled: true
  config:
    MB_DB_TYPE: postgres
    MB_DB_DBNAME: 'metabase'
    MB_DB_PORT:  5432
    MART_DB_NAME: martdb
  secrets:
    MB_ADMIN_FIRST_NAME: 'Admin'
    MB_DB_HOST: 'bahmni-TENANT_NAME-postgresql'
    MART_DB_HOST: 'bahmni-TENANT_NAME-postgresql'
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/bahmni/bahmni-metabase
    tag: 1.1.0-34

bahmni-mart:
  enabled: true
  config:
    MART_DB_NAME: martdb
  secrets:
    MART_DB_HOST: "bahmni-TENANT_NAME-postgresql"
  image:
    repository: 600047163007.dkr.ecr.ap-south-1.amazonaws.com
    name: bahmnilite/bahmni/bahmni-mart
    tag: 1.1.0-59
