FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive \
    TZ=UTC

# 로케일 설정
RUN apt-get update && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8

# 필요한 패키지 설치
RUN apt-get update && apt-get upgrade -yq && apt-get install -y \
    apt-utils \
    bear \
    build-essential \
    clang-tools \
    cppcheck \
    latexmk \
    graphviz \
    vim \
    u-boot-tools \
    lsof \
    net-tools \
    git \
    git-lfs \
    cmake \
    bison \
    flex \
    texlive \
    texlive-latex-extra \
    texlive-fonts-extra \
    pdftk \
    doxygen \
    texinfo \
    bzip2 \
    xz-utils \
    unzip \
    python3 \
    python3-xlrd \
    python3-dev \
    python3-venv \
    python3-pip \
    python3-sphinx \
    python-is-python3 \
    libpython2.7-dev \
    libpython3-dev \
    libexpat1-dev \
    zlib1g-dev \
    libtinfo-dev \
    libncurses5 \
    libncurses5-dev \
    wget \
    curl \
    tar \
    pax \
    ninja-build \
    pkg-config \
    # VSCode 원격 개발을 위한 추가 패키지
    sudo \
    locales \
    vim \
    ssh \
    openssh-server \
    g++ \
    # 디버깅 도구
    gdb \
    # 분석 도구
    cscope \
    exuberant-ctags \
    && rm -rf /var/lib/apt/lists/*

# 작업 디렉토리 설정
WORKDIR /opt

# RUN wget https://rtems-qual.io.esa.int/public_release/QDPV5/rtems-6-sparc-gr740-smp-5.tar.xz
# COPY rtems-6-sparc-gr740-smp-5.tar.xz .
COPY config.ini .
COPY test_config.ini .

CMD ["/bin/bash"]