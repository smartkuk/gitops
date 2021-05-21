#!/bin/bash

sed -i 's/smartkuk\/spring\-boot\-rest\:green/smartkuk\/spring\-boot\-rest\:blue/g' ./canary.yaml
git add .
git commit -m "switch green to blue"
git push