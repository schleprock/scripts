#! /usr/bin/env bash

echo "whoami: "
whoami
echo "Env:"
env
echo
if ! ~/scripts/test; then
	echo "SUCCESS: update was successful"
else
	echo "FAIL: update failed "
    exit 1
fi
exit 0
