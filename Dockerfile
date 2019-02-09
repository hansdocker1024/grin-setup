# docker build

ARG repository
FROM ${repository}:10.0-base-ubuntu18.04
LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"

ENV NCCL_VERSION 2.4.2

RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-libraries-$CUDA_PKG_VERSION \
        cuda-nvtx-$CUDA_PKG_VERSION \
        libnccl2=$NCCL_VERSION-1+cuda10.0 && \
    apt-mark hold libnccl2 && \
    rm -rf /var/lib/apt/lists/*


	
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


# nvidia-container-runtime @ https://gitlab.com/nvidia/cuda/blob/ubuntu16.04/8.0/runtime/Dockerfile
ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
LABEL com.nvidia.volumes.needed="nvidia_driver"
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility

WORKDIR /root	

RUN wget --no-check-certificate 'https://www.bminercontent.com/releases/bminer-v14.1.0-373029c-amd64.tar.xz' -O bminer-v14.3.0-cbb8683.tar.xz
RUN tar xf bminer-v14.3.0-cbb8683.tar.xz

RUN wget --no-check-certificate 'https://www.bminercontent.com/releases/bminer-v14.3.0-cbb8683-amd64.tar.xz' -O bminer-v14.3.0-cbb8683.tar.xz
RUN tar xf bminer-v14.3.0-cbb8683.tar.xz

RUN curl https://gist.githubusercontent.com/hansdocker1024/e182e2bcc8a8a5b825fe9887fe74f2bd/raw/runBminer.sh > runBminer.sh
RUN chmod +x runBminer.sh