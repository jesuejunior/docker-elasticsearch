FROM jolokia/alpine-jre-8
MAINTAINER Jesue Junior <jesuesousa@gmail.com>

# Set environment variables
ENV PKG_NAME elasticsearch
ENV ELASTICSEARCH_VERSION 2.3.1
ENV ELASTICSEARCH_URL https://download.elastic.co/$PKG_NAME/$PKG_NAME/$PKG_NAME-$ELASTICSEARCH_VERSION.tar.gz

# Download Elasticsearch

#ADD $ELASTICSEARCH_URL /tmp

COPY elasticsearch-2.3.1.tar.gz /tmp/

RUN addgroup -S elasticsearch && adduser -s /bin/bash -D -G elasticsearch elasticsearch \
    && apk update \
    && apk add openssl \
    && mkdir -p /opt \
    && tar xvzf /tmp/$PKG_NAME-$ELASTICSEARCH_VERSION.tar.gz -C /opt/ \
    && ln -s /opt/$PKG_NAME-$ELASTICSEARCH_VERSION /opt/$PKG_NAME \
    && rm -rf /tmp/*.tar.gz /var/cache/apk/*
#

WORKDIR /opt/$PKG_NAME

RUN set -ex \
	&& for path in \
		./data \
		./data/elk \
		./logs \
		./config \
		./config/scripts \
	; do \
		mkdir -p "$path"; \
	done \
    && chown -R elasticsearch:elasticsearch /opt/elasticsearch \
    && chmod 775 -R /opt/elasticsearch

# Add files
COPY config/elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml
COPY scripts/run.sh /scripts/run.sh

# Specify Volume
VOLUME ["/opt/elasticsearch"]

# Exposes
EXPOSE 9200 9300
USER elasticsearch

# CMD
ENTRYPOINT ["/scripts/run.sh"]