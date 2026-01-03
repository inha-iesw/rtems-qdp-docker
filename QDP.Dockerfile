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
    pv \
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
    clangd-11 \
    # 디버깅 도구
    gdb \
    # 분석 도구
    cscope \
    exuberant-ctags \
    # X11 패키지
    x11-apps \
    x11-utils \
    xauth \
    # GUI 라이브러리
    libx11-dev \
    libxext-dev \
    libxrender-dev \
    libxtst6 \
    # GTK/Qt 지원
    libgtk-3-dev \
    qt5-default \
    # 폰트 관련
    fontconfig \
    fonts-dejavu-core \
    # 오디오 지원
    pulseaudio-utils \
    # 개발 도구
    mesa-utils \
    && rm -rf /var/lib/apt/lists/*

# 작업 디렉토리 설정
WORKDIR /opt

# RUN wget https://rtems-qual.io.esa.int/public_release/QDPV5/rtems-6-sparc-gr740-smp-5.tar.xz
# COPY rtems-6-sparc-gr740-smp-5.tar.xz .
COPY config.ini .
COPY test_config.ini .


# X11 권한 설정 및 디렉토리 생성
RUN mkdir -p /tmp/.X11-unix && \
    chmod 1777 /tmp/.X11-unix && \
    mkdir -p /mnt/wslg

RUN echo '#!/bin/bash\necho "Testing GUI..."\necho "DISPLAY: $DISPLAY"\necho "XDG_RUNTIME_DIR: $XDG_RUNTIME_DIR"\nls -la /tmp/.X11-unix/\nls -la /mnt/wslg/ 2>/dev/null || echo "WSLg not mounted"\nxclock &\nsleep 2\nkillall xclock 2>/dev/null || true\necho "GUI test completed"' > /usr/local/bin/test-gui && \
    chmod +x /usr/local/bin/test-gui

CMD ["/bin/bash"]