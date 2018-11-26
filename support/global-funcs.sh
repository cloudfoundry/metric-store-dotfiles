msq() {
    echo "Querying ${BOSH_ENV_NAME} ..."
    stdout_tmpfile=$(mktemp)

    url="https://metric-store.${BOSH_ENV_NAME}.cf-denver.com/api/v1/query"
    stderr_output=$(curl -H "Authorization: $(cf oauth-token)" -sS -G ${url} \
        --data-urlencode query=${1} > ${stdout_tmpfile} 2>&1)
    curl_status=$?

    if [ $curl_status -eq 0 ]; then
        echo
        echo "curl -H \"Authorization: \$(cf oauth-token)\" -sS -G ${url}" \
            "--data-urlencode 'query=${1}'"
        echo
        cat ${stdout_tmpfile} | jq .
    else
        cat ${stdout_tmpfile}
    fi
}
