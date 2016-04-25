FROM jolokia/alpine-jre-8
MAINTAINER Jesue Junior <jesuesousa@gmail.com>

# Set environment variables
ENV PKG_NAME elasticsearch
ENV ELASTICSEARCH_VERSION 2.3.1
ENV ELASTICSEARCH_URL https://download.elastic.co/$PKG_NAME/$PKG_NAME/$PKG_NAME-$ELASTICSEARCH_VERSION.tar.gz
ENV ES_PATH = /opt/$PKG_NAME

# Download Elasticsearch

ADD $ELASTICSEARCH_URL /tmp
COPY scripts/run.sh /scripts/run.sh

RUN addgroup -S elasticsearch && adduser -s /bin/bash -D -G elasticsearch elasticsearch \
    && apk update \
    && apk add openssl \
    && mkdir -p /opt \
    && tar xvzf /tmp/$PKG_NAME-$ELASTICSEARCH_VERSION.tar.gz -C /opt/ \
    && ln -s /opt/$PKG_NAME-$ELASTICSEARCH_VERSION /opt/$PKG_NAME \
    && rm -rf /tmp/*.tar.gz /var/cache/apk/* \
    && set -ex \
	&& for path in \
		/$ES_PATH/data \
		/$ES_PATH/data/elk \
		/$ES_PATH/logs \
		/$ES_PATH/config \
		/$ES_PATH/config/scripts \
	; do \
		mkdir -p "$path"; \
	done \
    && chown -R elasticsearch:elasticsearch /opt /scripts \
    && chmod +x /scripts/run.sh

# Add files
COPY config/elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml


# Specify Volume
VOLUME ["/opt/elasticsearch/data", "/opt/elasticsearch/logs]

# Exposes
EXPOSE 9200 9300
USER elasticsearch

# CMD
ENTRYPOINT ["/scripts/run.sh"]