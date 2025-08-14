#!/bin/bash

# Script to run Netdata in Docker

docker run -d \
  --name=netdata \
  -p 19999:19999 \
  netdata/netdata
