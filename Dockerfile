# Copyright 2017 Evolved Binary Ltd
# Released under the AGPL v3.0 license

FROM gcr.io/distroless/java:latest

MAINTAINER Evolved Binary Ltd <tech@evolvedbinary.com>

ARG VCS_REF
ARG BUILD_DATE

LABEL name="eXist-db Docker" \
  vendor="Evolved Binary Ltd" \
  org.label-schema.schema-version="1.0" \
  org.label-schema.name="eXist-db Docker" \
  org.label-schema.vendor="Evolved Binary Ltd" \
  org.label-schema.url="https://exist-db.org" \
  org.label-schema.vcs-url="https://github.com/evolvedbinary/docker-existdb" \
  org.label-schema.vcs-ref=$VCS_REF \
  org.label-schema.build-date=$BUILD_DATE \
  org.label-schema.docker.cmd="docker run -it -p 9080:8080 -p 9443:8443"

COPY /target/exist /exist
COPY /target/conf.xml /exist/conf.xml
COPY /target/exist/webapp/WEB-INF/data /exist-data

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV EXIST_HOME=/exist

EXPOSE 8080
EXPOSE 8443

ENTRYPOINT ["/usr/lib/jvm/java-8-openjdk-amd64/bin/java"]
CMD ["-Dexist.home=/exist", "-jar", "/exist/start.jar", "jetty"]
