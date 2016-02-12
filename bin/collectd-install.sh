#!/bin/bash

build_dir=$1
my_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "build_dir is ${build_dir}"
echo "my_dir is ${my_dir}"
ls -l $my_dir

cp $my_dir/collectd*.sh $build_dir

pushd $build_dir
  echo "Unpacking and configuring collectd"
  tar xzf $my_dir/../collectd.tgz
  rm $my_dir/../collectd.tgz
  cp $my_dir/../collectd-related-config/collectd.template etc/collectd.conf
popd
