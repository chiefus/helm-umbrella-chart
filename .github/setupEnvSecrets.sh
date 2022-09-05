#!/bin/bash
set -e

function exportWithMask {
    SSM_PARAMETER_NAME=$1
    ENV_VARIABLE_NAME=$2

    PARAMETER_VALUE=$(aws ssm get-parameter --with-decryption --name "$SSM_PARAMETER_NAME" --query "Parameter.Value" --output text)
    echo "::add-mask::$PARAMETER_VALUE"
    echo "$ENV_VARIABLE_NAME=$PARAMETER_VALUE" >> $GITHUB_ENV
}

ENVIRONMENT=$1

exportWithMask "/$ENVIRONMENT/openmrs/DB_USERNAME" 'OPENMRS_DB_USERNAME'
exportWithMask "/$ENVIRONMENT/openmrs/DB_PASSWORD" 'OPENMRS_DB_PASSWORD'
exportWithMask "/$ENVIRONMENT/reports/DB_USERNAME" 'REPORTS_DB_USERNAME'
exportWithMask "/$ENVIRONMENT/reports/DB_PASSWORD" 'REPORTS_DB_PASSWORD'
exportWithMask "/$ENVIRONMENT/crater/DB_USERNAME" 'CRATER_DB_USERNAME'
exportWithMask "/$ENVIRONMENT/crater/DB_PASSWORD" 'CRATER_DB_PASSWORD'
exportWithMask "/$ENVIRONMENT/crater/ADMIN_PASSWORD" 'CRATER_ADMIN_PASSWORD'
exportWithMask "/litenonprod/rds/mysql/host" 'RDS_HOST'
exportWithMask "/litenonprod/rds/mysql/username" 'RDS_USERNAME'
exportWithMask "/litenonprod/rds/mysql/password" 'RDS_PASSWORD'
exportWithMask "/litenonprod/rabbitmq/USERNAME" 'MQ_USERNAME'
exportWithMask "/litenonprod/rabbitmq/PASSWORD" 'MQ_PASSWORD'
exportWithMask "/nonprod/psql/DB_PASSWORD" 'PSQL_PASSWORD'
exportWithMask "/$ENVIRONMENT/abdm/GATEWAY_CLIENT_ID" 'GATEWAY_CLIENT_ID'
exportWithMask "/$ENVIRONMENT/abdm/GATEWAY_CLIENT_SECRET" 'GATEWAY_CLIENT_SECRET'
exportWithMask "/litenonprod/efs/file_system_id" 'EFS_FILESYSTEM_ID'
