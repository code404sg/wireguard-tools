#!/bin/bash
CONFIG_FILE="${HOME}/wireguard/wgcg/wgcg.conf"
for CF in "${WGCG_CONFIG_FILE}" "${CONFIG_FILE}"; do
  if [[ -f "${CF}" ]]; then
    CONFIG_FILE="${CF}"
    source "${CONFIG_FILE}"
    break
  fi
done
NUM=20
MACHINE=$1
IP=$( expr $NUM + $MACHINE )
scp ${WGCG_WORKING_DIR}/client-sm${MACHINE}.conf shake@10.8.1.${IP}:/home/shake/
ssh shake@10.8.1.${IP} "
    sudo apt install wireguard -y && \
    sudo mv client-sm${MACHINE}.conf /etc/wireguard/wg0.conf && \
    sudo service wg-quick@wg0 restart
"