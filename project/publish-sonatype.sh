#!/usr/bin/env bash

set -e

basedir=$(cd "${BASH_SOURCE%/*}/.." && pwd)
revision=$(date +"%Y%m%d%H%M%S")

java_home="/usr/lib/jvm/java-8-jdk"

organization="com.carrotgarden.shocon"
version="0.2.2.${revision}"

echo "organization=$organization version=$version"

sbt_opts=(
   -java-home $java_home
   -Dsbt.log.noformat=true
)

sbt_args=(
   "set every organization := \"$organization\""
   "set every version := \"$version\""
)

pub_args=(
   publish-local
   parserJVM/publishSigned
   parserJS/publishSigned
   parserNative/publishSigned
   facadeJVM/publishSigned
   facadeJS/publishSigned
   facadeNative/publishSigned
)

cd "$basedir"

sbt "${sbt_opts[@]}" "${sbt_args[@]}" "${pub_args[@]}"  
