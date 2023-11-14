#! /usr/bin/env bash

testStr="./Twin/foo"
echo "testStr = $testStr"
backSlash="\\\\"
echo "backSlash = $backSlash"
forwardSlash="/"
echo "forwardSlash = $forwardSlash"
echo ${testStr//\//\\}

