#!/bin/bash

sed -i 's/smartkuk\/spring\-boot\-rest\:blue/smartkuk\/spring\-boot\-rest\:green/g' ./canary.yaml
git add .
git commit -m "switch blue to green"
git push