FROM ubuntu:22.04

ARG TARGETPLATFORM

ARG ZENOH_VER=0.11.0
ARG ASDF_VER=v0.14.0
ARG ERLANG_VER=26.2.5
ARG ELIXIR_VER="1.16.3-otp-26"

# Install Zenoh
RUN apt-get update && apt-get install -y \
  unzip wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN if [ ${TARGETPLATFORM} = "linux/amd64" ]; then \
	( wget https://github.com/eclipse-zenoh/zenoh/releases/download/${ZENOH_VER}/zenoh-${ZENOH_VER}-x86_64-unknown-linux-gnu-debian.zip -O /tmp/zenoh-pkgs.zip \
	&& unzip /tmp/zenoh-pkgs.zip -d /tmp \
	&& dpkg -i /tmp/zenoh*.deb \
	&& rm -f /tmp/* \
	) ; \
	fi;
RUN if [ ${TARGETPLATFORM} = "linux/arm64" ]; then \
	( wget https://github.com/eclipse-zenoh/zenoh/releases/download/${ZENOH_VER}/zenoh-${ZENOH_VER}-aarch64-unknown-linux-gnu-debian.zip -O /tmp/zenoh-pkgs.zip \
	&& unzip /tmp/zenoh-pkgs.zip -d /tmp \
	&& dpkg -i /tmp/zenoh*.deb \
	&& rm -f /tmp/* \
	) ; \
	fi;

# Install Rust
RUN apt-get update && apt-get install -y \
  curl build-essential \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install Python & zenoh-python
RUN apt-get update && apt-get install -y \
  python3-pip \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN pip install -U pip && \
  pip install --no-cache-dir eclipse-zenoh==${ZENOH_VER}

# Install ASDF
RUN apt-get update && apt-get install -y \
  curl git \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN git clone https://github.com/asdf-vm/asdf.git /root/.asdf --branch ${ASDF_VER} --depth 1 \
	&& echo '. "$HOME/.asdf/asdf.sh"' >> /root/.bashrc \
  && echo '. "$HOME/.asdf/completions/asdf.bash"' >> /root/.bashrc

# Install Erlang
RUN apt-get update && apt-get install -y \
	build-essential autoconf m4 libncurses5-dev libwxgtk3.0-gtk3-dev libwxgtk-webview3.0-gtk3-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN /root/.asdf/bin/asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git \
	&& /root/.asdf/bin/asdf install erlang ${ERLANG_VER} \
	&& /root/.asdf/bin/asdf global erlang ${ERLANG_VER}

# Install Elixir
RUN /root/.asdf/bin/asdf plugin add elixir https://github.com/asdf-vm/asdf-elixir.git \
	&& /root/.asdf/bin/asdf install elixir ${ELIXIR_VER} \
	&& /root/.asdf/bin/asdf global elixir ${ELIXIR_VER}

# Install for Phoenix app
RUN apt-get update && apt-get install -y \
	inotify-tools nodejs npm locales \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*
RUN locale-gen en_US.UTF-8 \
	&& echo 'export LANG=en_US.UTF-8' >> /root/.bashrc \
	&& echo 'export LC_CTYPE=en_US.UTF-8' >> /root/.bashrc

CMD ["/bin/bash"]
