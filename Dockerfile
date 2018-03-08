FROM mdillon/postgis:9.5

ENV GEOS_VERSION 3.5.1
ENV POSTGIS_VERSION 2.4.3

RUN apt-get update && \
    apt-get install -y build-essential wget postgresql-server-dev-9.5 libxml2-dev libproj-dev libgdal-dev \
    libjson-c-dev libpcre3-dev postgresql-plperl-9.5

RUN cd tmp && \
    wget http://download.osgeo.org/geos/geos-${GEOS_VERSION}.tar.bz2 && \
    tar xfj geos-${GEOS_VERSION}.tar.bz2 && \
    cd geos-${GEOS_VERSION} && \
    ./configure && make && make install

RUN cd tmp && \
    wget http://download.osgeo.org/postgis/source/postgis-${POSTGIS_VERSION}.tar.gz && \
    tar xfz postgis-${POSTGIS_VERSION}.tar.gz && \
    cd postgis-${POSTGIS_VERSION} && \
    ./configure && make && make install

RUN rm -Rf /tmp/*
RUN apt-get purge -y --auto-remove build-essential wget postgresql-server-dev-9.5 libxml2-dev libproj-dev libgdal-dev \
    libjson-c-dev libpcre3-dev
