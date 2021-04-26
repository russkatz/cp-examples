#!/bin/sh

test="THIS IS A TEST"

cat << EOF >> testfile.txt
here is a test: $test
EOF
