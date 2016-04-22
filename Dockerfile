FROM jolokia/alpine-jre-8
MAINTAINER Jesue Junior <jesuesousa@gmail.com>

# Set environment variables
ENV PKG_NAME elasticsearch
ENV ELASTICSEARCH_VERSION 2.3.1
ENV ELASTICSEARCH_URL https://download.elastic.co/$PKG_NAME/$PKG_NAME/$PKG_NAME-$ELASTICSEARCH_VERSION.tar.gz

# Download Elasticsearch

ADD $ELASTICSEARCH_URL /tmp

RUN apk update \
    && apk add openssl \
    && mkdir -p /opt \  
    && tar -xvzf /tmp/$PKG_NAME-$ELASTICSEARCH_VERSION.tar.gz -C /opt/ \
    && ln -s /opt/$PKG_NAME-$ELASTICSEARCH_VERSION /opt/$PKG_NAME \
    && rm -rf /tmp/*.tar.gz /var/cache/apk/* \
    && mkdir /var/lib/elasticsearch \
    && chown nobody /var/lib/elasticsearch

# Add files
COPY config/elasticsearch.yml /opt/elasticsearch/config/elasticsearch.yml
COPY scripts/run.sh /scripts/run.sh

# Specify Volume
VOLUME ["/var/lib/elasticsearch"]

# Exposes
EXPOSE 9200
EXPOSE 9300

USER nobody

# CMD
ENTRYPOINT ["/scripts/run.sh"]
