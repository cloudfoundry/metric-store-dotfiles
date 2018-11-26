msq() {
    echo "Querying ${BOSH_ENV_NAME}"
    stdout_tmpfile=$(mktemp)

    stderr_output=$(curl -H "Authorization: $(cf oauth-token)" -sS -G https://metric-store.${BOSH_ENV_NAME}.cf-denver.com/api/v1/query --data-urlencode ${1} > ${stdout_tmpfile} 2>&1)
    curl_status=$?

    if [ $curl_status -eq 0 ]; then
        cat ${stdout_tmpfile} | jq .
    else
        cat ${stdout_tmpfile}
    fi
}
