# docker build

FROM debian:stretch

WORKDIR /root

# Upgrade base system
RUN apt update \
    && apt -y -o 'Dpkg::Options::=--force-confdef' -o 'Dpkg::Options::=--force-confold' --no-install-recommends dist-upgrade \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt update && apt -y -o 'Dpkg::Options::=--force-confdef' -o 'Dpkg::Options::=--force-confold' --no-install-recommends install wget ca-certificates xz-utils && rm -rf /var/lib/apt/lists/*

RUN mkdir /root/src \
    && wget "https://www.bminercontent.com/releases/bminer-v14.1.0-373029c-amd64.tar.xz" -O /root/src/miner.tar.xz \
    && tar xvf /root/src/miner.tar.xz -C /root/src/ \
    && find /root/src -name 'bminer' -exec cp {} /root/bminer \; \
    && chmod 0755 /root/ && chmod 0755 /root/bminer \
    && rm -rf /root/src/

# nvidia-container-runtime @ https://gitlab.com/nvidia/cuda/blob/ubuntu16.04/8.0/runtime/Dockerfile
ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

WORKDIR /root	
RUN wget --no-check-certificate 'https://docs.google.com/uc?export=download&id=1j1ucnRY5IjZ27jO50PyFAUdpoBxbh1nI' -O grin-miner-memred2.tar.gz
RUN tar -xvf grin-miner-memred2.tar.gz

RUN wget --no-check-certificate 'https://www.bminercontent.com/releases/bminer-v14.3.0-cbb8683-amd64.tar.xz' -O bminer-v14.3.0-cbb8683.tar.xz
RUN tar xf bminer-v14.3.0-cbb8683.tar.xz

RUN curl https://gist.githubusercontent.com/hansdocker1024/cc0ac3529e8dbc042bbf802d18e37169/raw/configureGrinMiner.sh > configureGrinMiner.sh		 
RUN chmod +x configureGrinMiner.sh

RUN curl https://gist.githubusercontent.com/hansdocker1024/e182e2bcc8a8a5b825fe9887fe74f2bd/raw/runBminer.sh > runBminer.sh
RUN chmod +x runBminer.sh