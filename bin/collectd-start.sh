#!/bin/bash

IFS=":"; read -a MT_GRAPHITE_ENDPOINT <<<"$remote_metrics_target"
IFS=

sed "s/REPLACE_METRICS_TARGET_HOST/${MT_GRAPHITE_ENDPOINT[0]}/" -i /home/vcap/app/collectd/etc/collectd.conf
sed "s/REPLACE_METRICS_TARGET_PORT/${MT_GRAPHITE_ENDPOINT[1]}/" -i /home/vcap/app/collectd/etc/collectd.conf

if [[ -n "$logmet_tenant_id" ]]; then
    sed "s/REPLACE_SPACE_GUID/${logmet_tenant_id}/" -i /home/vcap/app/collectd/etc/collectd.conf
else
    sed "s/REPLACE_SPACE_GUID/${tenant_id}/" -i /home/vcap/app/collectd/etc/collectd.conf
fi

if [[ -n "$remote_logging_password" ]]; then
    sed "s/REPLACE_LOGGING_TOKEN/${remote_logging_password}/" -i /home/vcap/app/collectd/etc/collectd.conf
else
    sed "s/REPLACE_LOGGING_TOKEN/${activedeploy_logging_password}/" -i /home/vcap/app/collectd/etc/collectd.conf
fi

if [[ -n "$metrics_group_id" ]]; then
    sed "s/REPLACE_GRAPHITE_PREFIX/${metrics_group_id}/" -i /home/vcap/app/collectd/etc/collectd.conf
else
    sed "s/REPLACE_GRAPHITE_PREFIX//" -i /home/vcap/app/collectd/etc/collectd.conf
fi

echo "Starting collectd"
/home/vcap/app/collectd/sbin/collectd -C /home/vcap/app/collectd/etc/collectd.conf
