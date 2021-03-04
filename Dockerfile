FROM cimg/go:1.16

# INSTALL BUILDX
ENV BUILDX_VERSION=0.5.1
RUN mkdir -vp ~/.docker/cli-plugins/ && \
    curl --silent -L --output ~/.docker/cli-plugins/docker-buildx "https://github.com/docker/buildx/releases/download/v${BUILDX_VERSION}/buildx-v${BUILDX_VERSION}.linux-amd64" && \
    chmod a+x ~/.docker/cli-plugins/docker-buildx && \
    docker buildx version

# INSTALL NODE

ENV NODE_VERSION 14.16.0

RUN curl -L -o node.tar.xz "https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz" && \
	sudo tar -xJf node.tar.xz -C /usr/local --strip-components=1 && \
	rm node.tar.xz && \
	sudo ln -s /usr/local/bin/node /usr/local/bin/nodejs

ENV YARN_VERSION 1.22.10
RUN curl -L -o yarn.tar.gz "https://yarnpkg.com/downloads/${YARN_VERSION}/yarn-v${YARN_VERSION}.tar.gz" && \
	sudo tar -xzf yarn.tar.gz -C /opt/ && \
	rm yarn.tar.gz && \
	sudo ln -s /opt/yarn-v${YARN_VERSION}/bin/yarn /usr/local/bin/yarn && \
	sudo ln -s /opt/yarn-v${YARN_VERSION}/bin/yarnpkg /usr/local/bin/yarnpkg

# INSTALL TOOLS

RUN sudo npm i -g commitlint@12.0.1
RUN sudo npm i -g standard-version@9.1.1