# 🚀 RTEMS QDP Docker

> 🎯 **목표**: RTEMS 실시간 운영체제 개발을 위한 완벽한 Docker 환경 구축

## 📋 목차

- [🌟 프로젝트 소개](#-프로젝트-소개)
- [🛠️ 개발환경 선택](#️-개발환경-선택)
- [📦 설치 및 실행](#-설치-및-실행)
- [🎮 사용법](#-사용법)
- [🔧 고급 설정](#-고급-설정)
- [❓ 문제해결](#-문제해결)

## 🌟 프로젝트 소개

이 프로젝트는 **RTEMS (Real-Time Executive for Multiprocessor Systems)** 개발을 위한 Docker 기반 환경을 제공합니다.

### ✨ 주요 특징

- 🐳 **Docker 기반**: 일관된 개발 환경 보장
- 🎯 **두 가지 개발 모드**: QDP와 표준 RTEMS 개발 지원
- 🔧 **완전 자동화**: 원클릭 환경 구축
- 📱 **VSCode 통합**: 원격 개발 완벽 지원

## 🛠️ 개발환경 선택

프로젝트는 두 가지 개발 환경을 제공합니다:

### 🏆 QDP 환경

```bash
# QDP 개발 플랫폼
# SPARC GR740 SMP 아키텍처 지원
./setup-qdp.sh
```

### ⚡ 표준 RTEMS 환경

```bash
# 일반적인 RTEMS 개발환경
# SPARC Leon3 BSP 지원
./setup-kernel.sh
```

## 📦 설치 및 실행

### 1️⃣ 사전 준비사항

> 💡 **팁**: Docker Desktop을 미리 설치해주세요!

- [Docker Desktop](https://www.docker.com/products/docker-desktop/) 설치
- VSCode 설치
- 최소 4GB 메모리 할당

### 2️⃣ 저장소 클론

```bash
git clone https://github.com/inha-iesw/rtems-qdp-docker
cd rtems-qdp-docker
```

### 3️⃣VSCode 통합 개발

1. **Remote-Containers 확장 설치**
2. **Ctrl+Shift+P** → "Reopen in Container" 클릭

### 🚀 QDP 환경으로 시작하기

```bash
# 컨테이너 내부에서 실행
./setup-qdp.sh

# ✅ 설치 완료 후 사용 가능한 도구들:
# - RTEMS 6 SPARC GR740 SMP 툴체인
# - 인증된 개발 라이브러리
# - 품질 보증 도구
```

**📁 QDP 설치 위치**: `/opt/rtems-6-sparc-gr740-smp-5/`

### ⚡ 표준 RTEMS 환경으로 시작하기

```bash
# 컨테이너 내부에서 실행
./setup-kernel.sh

# ✅ 설치되는 구성요소:
# 1. RTEMS Source Builder (툴체인)
# 2. RTEMS 6.1 커널 소스
# 3. SPARC Leon3 BSP 빌드
```

**📁 RTEMS 설치 위치**: `/opt/rtems/6/`

## 🔧 고급 설정

### ⚙️ 빌드 설정 커스터마이징

**config.ini** 파일을 수정하여 빌드 옵션을 조정할 수 있습니다:

```ini
[sparc/gr740]
RTEMS_SMP=True          # 🔄 멀티프로세싱 활성화
RTEMS_POSIX_API=True    # 📚 POSIX API 지원
BUILD_TESTS=True        # 🧪 테스트 빌드 포함
```

## 📊 프로젝트 구조

```
rtems-qdp-docker/
├── 📄 QDP.Dockerfile                    # Docker 이미지 정의
├── 📖 README.md                         # 이 파일
├── ⚙️ config.ini                       # RTEMS 빌드 설정
├── 🧪 test_config.ini                  # 테스트 설정
├── 🚀 setup-qdp.sh                     # QDP 환경 설치 스크립트
├── ⚡ setup-kernel.sh                  # 표준 RTEMS 환경 설치 스크립트
└── 📋 sparc-gr712rc-smp-user-qual.yml  # SPARC 사용자 자격 설정
```

## 📞 도움이 필요하세요?

- 🔗 [RTEMS 공식 문서](https://docs.rtems.org/)
- 🌐 [ESA QDP 포털](https://rtems-qual.io.esa.int/)
- 📧 Issue 등록을 통한 문의
