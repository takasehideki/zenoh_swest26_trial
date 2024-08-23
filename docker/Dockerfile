FROM hexpm/elixir:1.16.3-erlang-26.2.5.2-ubuntu-jammy-20240808

ARG TARGETPLATFORM

ARG ZENOH_VER=0.11.0

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

# Install for Phoenix app
RUN apt-get update && apt-get install -y \
	git inotify-tools \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

CMD ["/bin/bash"]
