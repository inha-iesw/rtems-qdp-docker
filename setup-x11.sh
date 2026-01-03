#!/bin/bash

echo "Setting up X11 for GUI applications..."

# WSL2에서 Windows 호스트 IP 가져오기
if [ -z "$DISPLAY" ]; then
    export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0.0
    echo "Set DISPLAY to: $DISPLAY"
fi

# X11 소켓 권한 설정
if [ -d "/tmp/.X11-unix" ]; then
    sudo chmod 1777 /tmp/.X11-unix
    echo "X11 socket permissions set"
fi

# XAuthority 설정
if [ ! -f "$HOME/.Xauthority" ]; then
    touch $HOME/.Xauthority
    echo "Created .Xauthority file"
fi

# 환경변수 내보내기
echo "export DISPLAY=$DISPLAY" >> ~/.bashrc
echo "export LIBGL_ALWAYS_INDIRECT=1" >> ~/.bashrc

echo "X11 setup completed!"
echo "Current DISPLAY: $DISPLAY"
echo "Test with: xclock"

# 간단한 테스트
if command -v xclock >/dev/null 2>&1; then
    echo "Testing xclock..."
    timeout 3s xclock 2>/dev/null && echo "GUI test successful!" || echo "GUI test failed - check X11 server"
fi