#!/bin/bash
# Source: https://github.com/ruimarinho/docker-bitcoin-core/blob/master/0.18/docker-entrypoint.sh

set -e

if [ ! -e "$LIGHTNING_DATA/config" ]; then
    echo "$0: creating $LIGHTNING_DATA/config with network=signet"
    echo -e "network=signet\nbitcoin-rpcconnect=docker-fullnode\nlog-level=debug\nbitcoin-rpcuser=hoge\nbitcoin-rpcpassword=hoge\n$LIGHTNING_EXTRA_ARGS" > $LIGHTNING_DATA/config
fi

if [ $(echo "$1" | cut -c1) = "-" ]; then
  echo "$0: assuming arguments for lightningd"
  set -- lightningd "$@"
fi

if [ $(echo "$1" | cut -c1) = "-" ] || [ "$1" = "lightningd" ]; then
  mkdir -p "$LIGHTNING_DATA"
  chmod 700 "$LIGHTNING_DATA"

  echo "$0: setting data directory to $LIGHTNING_DATA"
fi

echo
exec "$@"
