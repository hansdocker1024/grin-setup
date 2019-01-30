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
	pciutils

WORKDIR /root	
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1woeQEy70mekTNIF_uRK7Wy3Zfio7bSAE' -O grin-miner-memred2.tar.gz
RUN tar -xvf grin-miner-memred2.tar.gz

RUN echo '/root/configureGrinMiner' >> onstart.sh
#RUN echo '/root/grin-miner' >> onstart.sh
RUN chmod +x onstart.sh
