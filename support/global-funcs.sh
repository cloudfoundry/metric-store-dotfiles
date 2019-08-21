msq() {
    echo "Querying ${BOSH_ENV_NAME} ..."
    stdout_tmpfile=$(mktemp)

    url="https://metric-store.${BOSH_ENV_NAME}.cf-denver.com/api/v1/query"
    stderr_output=$(curl -k -H "Authorization: $(cf oauth-token)" -sS -G ${url} \
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

tmux_get_window_name() {
    if [ -v TMUX ]; then
        tmux display-message -p "#W"
    fi
}

tmux_set_window_name_from_panes() {
    if [ -v TMUX ]; then
        window_name=$(tmux list-panes -F "#T" | paste -s -d "+")
        tmux_set_window_name ${window_name}
    fi
}

tmux_get_pane_title() {
    if [ -v TMUX ]; then
        tmux display-message -p "#T"
    fi
}

tmux_set_window_name() {
    local window_name=${1}

    if [ -v TMUX ]; then
        printf "\033k${window_name}\033\\"
    fi
}

tmux_set_pane_title() {
    local pane_title=${1}

    if [ -v TMUX ]; then
        printf "\033]2;${pane_title}\033\\"
    fi
}

tmux_try_rename() {
    local pane_title=${1}
    local current_title=$(tmux_get_pane_title)

    if [[ "${current_title}" != "Bosh Prod" ]]; then
        tmux_set_pane_title $pane_title
        tmux_set_window_name_from_panes
    fi
}

target_prod() {
    local current_window_name=$(tmux_get_window_name)

    cat > /tmp/director_ca.crt <<EOF
-----BEGIN CERTIFICATE-----
MIIDtzCCAp+gAwIBAgIJAPCHksVa5MwFMA0GCSqGSIb3DQEBBQUAMEUxCzAJBgNV
BAYTAkFVMRMwEQYDVQQIEwpTb21lLVN0YXRlMSEwHwYDVQQKExhJbnRlcm5ldCBX
aWRnaXRzIFB0eSBMdGQwIBcNMTYwODA4MTkxOTA2WhgPMjI5MDA1MjMxOTE5MDZa
MEUxCzAJBgNVBAYTAkFVMRMwEQYDVQQIEwpTb21lLVN0YXRlMSEwHwYDVQQKExhJ
bnRlcm5ldCBXaWRnaXRzIFB0eSBMdGQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDTS6SRhpVkNY2MJErFdsT6SM5CjkiZH79iZuXXhCrRYHM6evl/1mFR
wazNy/D0/fVMBmOI6Pac59i/LKfBKIajH3HaLcRPVI+l6PdXgJIwyKB+9ZL4TW0v
CerBzMIH1FgWEa1hF8sJ+q3KIJlL01+c8Fxbu/jCmIuVLNbDUfgwCGLYyIE5BjG8
ihlBcrq8T45xr2wzoNj9CLrMH52LjwO9YG6FdQdO7uWM9tNgoX6vKg4SZYWIoCnH
hD6fWr1wAEzKjQ5kdM7QsEO6eW+5iebpg+ImTcgY/8Z9MIDRxHgv2X1c2zGTbf5j
qQhrG//0JBWK93T4dEw+f4ryuMyMy6jhAgMBAAGjgacwgaQwHQYDVR0OBBYEFAIT
q1U0/RLQOV17AU9pz08IIQrVMHUGA1UdIwRuMGyAFAITq1U0/RLQOV17AU9pz08I
IQrVoUmkRzBFMQswCQYDVQQGEwJBVTETMBEGA1UECBMKU29tZS1TdGF0ZTEhMB8G
A1UEChMYSW50ZXJuZXQgV2lkZ2l0cyBQdHkgTHRkggkA8IeSxVrkzAUwDAYDVR0T
BAUwAwEB/zANBgkqhkiG9w0BAQUFAAOCAQEARVGFcNg6Rk30YlZyL94KlgGSFzp8
g+bC2iAWm7nbOQKj/ZiaiUgo4uY15ZORHPXdkG2JkZJvuLU6+wyWm+/uEgzxFnP8
5rKlvMmKZA/xMpfsiqlK6lVszL8Ulcv0OABmaHo0sprwH8Xwd3l2RJ07RlH7EAbT
OjtJX0Kkq7XnoKbDuOpPZt3RBQdkrlZhzmjJXVK8EDIZzBkUtV5TSIJcxEu+l+r+
HC9IuJyGE8jQlCdgfQ59meJ9HEaw+iz+c41KNFrsClwhqE1nV6C60e3MgGkJ+BBF
aPsjt21GbFavVxvFuNsH+xr8VKn63kIj9NI3Gpx2w6vOBAyHlhvh27v5xw==
-----END CERTIFICATE-----
EOF

    sudo date

    ssoca -e pws-prod env set https://ssoca-vpn.run.pivotal.io
    ssoca -e pws-prod auth login
    ssoca -e pws-prod openvpn exec --sudo --static-certificate >/tmp/ssoca.log 2>&1 &
    SSOCA_PID=$!
    trap "cleanup_prod ${SSOCA_PID} ${current_window_name}" EXIT

    echo "This might take a second while the VPN gets established..."
    bosh alias-env prod -e 10.10.0.7 --ca-cert /tmp/director_ca.crt
    bosh -e prod login
    export BOSH_ENVIRONMENT=prod

    tmux_set_window_name "Bosh Prod"
    zsh
}

cleanup_prod() {
    local ssoca_pid=${1}
    local previous_window_name=${2}

    kill ${ssoca_pid}
    ssoca -e pws-prod auth logout
    unset BOSH_ENVIRONMENT
    rm /tmp/director_ca.crt
    tmux_set_window_name ${previous_window_name}
}
