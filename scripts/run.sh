#!/bin/sh
# production recommendations http://www.elastic.co/guide/en/elasticsearch/guide/current/deploy.html

echo "-------------------------------"
echo "files in volume"
echo "-------------------------------"

vol=/opt/elasticsearch

esopts=""
if [ -f "$vol/config/elasticsearch.yml" ]; then
  esopts="-Des.path.home=$vol";
  echo "setting es.path.home to $vol"
else
  echo "[WARNING] missing elasticsearch config. not setting es.path.home to $vol"
fi

echo "-------------------------------"
echo "elastic search command"
echo "-------------------------------"

echo "/opt/elasticsearch/bin/elasticsearch $commandopts $esopts"

start() {
	exec /opt/elasticsearch/bin/elasticsearch $esopts
}

start
