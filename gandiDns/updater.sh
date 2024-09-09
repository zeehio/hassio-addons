#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: GandiDns
#
# GandiDNS add-on for Hass.io.
# This add-on update public IP on Gandi API.
# ==============================================================================

get_current_ip() {
    echo "$(curl -s ifconfig.me)"
}

get_gandi_ip() {
    domain=$1
    record=$2
    token=$3
    
    bashio::log.debug "[Gandi] - Get data for - ${domain} - ${record}"
    response=$(curl -s -H "Authorization: Bearer ${token}" https://api.gandi.net/v5/livedns/domains/${domain}/records/${record})
    echo "$response" | jq -r '.[].rrset_values[0]' || bashio::log.error "Error parsing $response"
}

update_gandi_ip() {
    domain=$1
    record=$2
    token=$3
    ip=$4
    payload='{"items": [{"rrset_type": "A","rrset_values": ["'"${ip}"'"],"rrset_ttl": 300}]}'
    bashio::log.debug "[Gandi] - Update record - ${domain} - ${record}"
    echo "$(curl -s -g -X PUT -H "Content-Type: application/json" -d "${payload}" -H "Authorization: Bearer ${token}" -o /dev/null -w "%{http_code}" https://api.gandi.net/v5/livedns/domains/${domain}/records/${record})"

}
# ==============================================================================
# RUN LOGIC
# ------------------------------------------------------------------------------
main() {
    local domain
    local records
    local token
    local current_ip
    local gandi_ip


    domain=$(bashio::config 'domain')
    records=$(bashio::config 'records')
    token=$(bashio::config 'token')

    bashio::log.trace "${FUNCNAME[0]}"
    bashio::log.info "Updater Started"
    current_ip=$(get_current_ip)
    bashio::log.info "Current ip is ${current_ip}"

    gandi_ip=$(get_gandi_ip "${domain}" "${records[0]}" "${token}")
    bashio::log.info "Gandi ip is ${gandi_ip:=not set}"

    if [ "${gandi_ip}" = "Invalid response" ]; then
        bashio::log.error "Could not get Ip from API, make sure your PAT is working"
    elif [ "${current_ip}" = "${gandi_ip}" ]; then
        bashio::log.info "Nothing to do, Ip is correct"
    else
        bashio::log.debug "Ip did not match, need an update"
        for record in ${records}
        do
            bashio::log.debug "Updating record ${record}"
            res=$(update_gandi_ip "${domain}" "${record}" "${token}" "${current_ip}")
            if [ "${res}" = "201" ]; then
                bashio::log.info "[GandiDns] - Domain ${record}.${domain} updated with IP ${current_ip}"
            else
                bashio::log.error "Error ${res} while setting DNS, make sur your PAT has the right permissions."
            fi
        done
    fi
}
main "$@"
