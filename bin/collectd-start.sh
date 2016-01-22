#!/bin/bash

IFS=":"; read -a MT_GRAPHITE_ENDPOINT <<<"$remote_metrics_target"
IFS=

sed "s/REPLACE_METRICS_TARGET_HOST/${MT_GRAPHITE_ENDPOINT[0]}/" -i /etc/collectd/collectd.conf

if [[ -n "$logmet_tenant_id" ]]; then
    sed "s/REPLACE_SPACE_GUID/${logmet_tenant_id}/" -i /etc/collectd/collectd.conf
else
    sed "s/REPLACE_SPACE_GUID/${tenant_id}/" -i /etc/collectd/collectd.conf
fi

if [[ -n "$remote_logging_password" ]]; then 
    sed "s/REPLACE_LOGGING_TOKEN/${remote_logging_password}/" -i /etc/collectd/collectd.conf
else
    sed "s/REPLACE_LOGGING_TOKEN/${activedeploy_logging_password}/" -i /etc/collectd/collectd.conf
fi

if [[ -n "$GRAPHITE_PREFIX" ]]; then
    sed "s/REPLACE_GRAPHITE_PREFIX/${GRAPHITE_PREFIX}/" -i /etc/collectd/collectd.conf
else
    sed "s/REPLACE_GRAPHITE_PREFIX//" -i /etc/collectd/collectd.conf  
fi

/home/vcap/app/collectd/sbin/collectd -C /home/vcap/app/etc/collectd.conf
