FROM ubuntu:bionic

RUN mkdir -p /app \
    && apt-get update -y \
    && apt-get -y --no-install-recommends install \
        python3-pip \
        python3-dev \
        python3-setuptools \
        gcc \

        # Python dependencies
        libglib2.0-0 \
        libsm6 \
        libxrender1 \
        libxext6 \
    && rm -rf /var/cache/apk/* \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --no-cache-dir --upgrade pip

WORKDIR /app

COPY requirements.txt /app/

RUN cd /app \
    && export LC_ALL=C.UTF-8 \
    && pip3 install --no-cache-dir -r /app/requirements.txt \
    && pip3 install https://github.com/pySTEPS/pysteps/archive/v1.3.0.tar.gz
