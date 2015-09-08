#!/bin/bash

set -e
set -x

source utility.sh

create_stack aws-bamboo file://aws/master/bamboo-template.json file://aws/master/bamboo-params.json