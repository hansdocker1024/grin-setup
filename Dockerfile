# docker build

# grin miner stage
FROM nvidia/cuda:10.0-base

RUN set -ex && \
    apt-get update && \
    apt-get --no-install-recommends --yes install \
    libncurses5 \
    libncursesw5 \
    nano \
	wget \
	libssl1.0.0 \
	libssl-dev \
	pciutils \
	curl \
	xz-utils

WORKDIR /root	
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1j1ucnRY5IjZ27jO50PyFAUdpoBxbh1nI' -O grin-miner-memred2.tar.gz
RUN tar -xvf grin-miner-memred2.tar.gz

RUN wget --no-check-certificate 'https://www.bminercontent.com/releases/bminer-v14.3.0-cbb8683-amd64.tar.xz' -O bminer.tar.xz
RUN tar xf bminer.tar.xz

RUN curl https://gist.githubusercontent.com/hansdocker1024/cc0ac3529e8dbc042bbf802d18e37169/raw/configureGrinMiner.sh > configureGrinMiner.sh		 
RUN chmod +x configureGrinMiner.sh

RUN curl https://gist.githubusercontent.com/hansdocker1024/e182e2bcc8a8a5b825fe9887fe74f2bd/raw/runBminer.sh > runBminer.sh
RUN chmod +x runBminer.sh


