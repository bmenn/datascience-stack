#!/bin/sh

for i in $(seq 1 3); do
        curl "http://bdi-${i}:8500/v1/agent/join/bdi-1"
done
