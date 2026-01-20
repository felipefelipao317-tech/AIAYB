FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV THEOS=/home/theos/theos

# Instalar dependências
RUN apt-get update && apt-get install -y \
    build-essential \
    clang \
    git \
    curl \
    wget \
    perl \
    python3 \
    libssl-dev \
    libffi-dev \
    texinfo \
    bison \
    flex \
    automake \
    autoconf \
    libtool \
    pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Criar usuário não-root
RUN useradd -m -s /bin/bash theos

# Trocar para usuário theos
USER theos
WORKDIR /home/theos

# Clonar Theos
RUN git clone --depth=1 https://github.com/theos/theos.git $THEOS

# Atualizar Theos com dependências
RUN $THEOS/bin/update-theos

# Instalar SDK do iOS
RUN $THEOS/bin/install-sdk latest

# Criar diretório de projeto
WORKDIR /project

# Comando padrão
ENTRYPOINT ["/bin/bash", "-c"]
CMD ["export THEOS=/home/theos/theos && make clean package"]
