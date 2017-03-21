#!/bin/bash

nginx=$(curl localhost > /dev/null; echo $?)
services=('nginx')
for service in ${services[*]}; do
        eval status=\$$service
        if [[ "$status" -ne 0 ]]
        then
        	service="${service//_/-}"
        	service $service start
        fi
done