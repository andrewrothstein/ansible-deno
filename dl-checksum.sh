#!/usr/bin/env bash
set -e
DIR=~/Downloads
MIRROR=https://github.com/denoland/deno/releases/download

# https://github.com/denoland/deno/releases/download/v1.22.0/deno-x86_64-unknown-linux-gnu.zip

dl()
{
    local -r ver=$1
    local -r os=$2
    local -r arch=$3
    local -r platform="${os}-${arch}"
    local url=$MIRROR/v$ver/deno-${arch}-${os}.zip
    local lfile=$DIR/deno-${ver}-${platform}.zip

    if [ ! -e $lfile ];
    then
        curl -sSLf -o $lfile $url
    fi

    printf "    # %s\n" $url
    printf "    %s: sha256:%s\n" $platform $(sha256sum $lfile | awk '{print $1}')
}

dl_ver() {
    local ver=$1
    printf "  '%s':\n" $ver
    dl $ver unknown-linux-gnu x86_64
    dl $ver pc-windows-msvc x86_64
    dl $ver apple-darwin x86_64
    dl $ver apple-darwin aarch64
}

dl_ver ${1:-1.35.0}
