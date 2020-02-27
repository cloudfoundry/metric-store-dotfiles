export OM_USERNAME=$(jq .ops_manager.username -r ~/workspace/denver-locks/acceptance-bosh/claimed/manila.json )
export OM_PASSWORD=$(jq .ops_manager.password -r  ~/workspace/denver-locks/acceptance-bosh/claimed/manila.json )
export OM_TARGET=$(jq .ops_manager.url  -r  ~/workspace/denver-locks/acceptance-bosh/claimed/manila.json )
export OM_SKIP_SSL_VALIDATION=true

source <(om bosh-env)
bosh alias-env manila -e $BOSH_ENVIRONMENT
export BOSH_ENVIRONMENT=manila


export PKS_USERNAME=$(jq .pks_api.uaa_admin_user -r ~/workspace/denver-locks/acceptance-bosh/claimed/manila.json )
export PKS_PASSWORD=$(jq .pks_api.uaa_admin_password -r  ~/workspace/denver-locks/acceptance-bosh/claimed/manila.json )
export PKS_TARGET=$(jq .pks_api.url  -r  ~/workspace/denver-locks/acceptance-bosh/claimed/manila.json )

pks login -a $PKS_TARGET -u $PKS_USERNAME -p $PKS_PASSWORD -k
