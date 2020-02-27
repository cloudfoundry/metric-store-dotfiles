ENV_FILE=~/workspace/denver-locks/acceptance-bosh/claimed/manila.json

export OM_USERNAME=$(jq .ops_manager.username -r ${ENV_FILE} )
export OM_PASSWORD=$(jq .ops_manager.password -r  ${ENV_FILE} )
export OM_TARGET=$(jq .ops_manager.url  -r  ${ENV_FILE} )
export OM_SKIP_SSL_VALIDATION=true

source <(om bosh-env)

jq .ops_manager_private_key -r ${ENV_FILE} > /tmp/manila.key
export OPS_MANAGER_DNS=$(jq .ops_manager_dns -r ${ENV_FILE})
export BOSH_ALL_PROXY="ssh+socks5://ubuntu@${OPS_MANAGER_DNS}:22?private-key=/tmp/manila.key"
export CREDHUB_ALL_PROXY=${BOSH_ALL_PROXY}

bosh alias-env manila -e $BOSH_ENVIRONMENT
export BOSH_ENVIRONMENT=manila

export PKS_USERNAME=$(jq .pks_api.uaa_admin_user -r ${ENV_FILE} )
export PKS_PASSWORD=$(jq .pks_api.uaa_admin_password -r  ${ENV_FILE} )
export PKS_TARGET=$(jq .pks_api.url  -r  ${ENV_FILE} )

pks login -a $PKS_TARGET -u $PKS_USERNAME -p $PKS_PASSWORD -k
