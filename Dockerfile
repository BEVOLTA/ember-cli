FROM node:16
MAINTAINER Fabien Foerster <f.foerster@bevolta.com>

RUN apt-get update && apt-get -y upgrade && \
    apt-get install -y --no-install-recommends zip && \
    apt-get install -y --no-install-recommends git && \
    apt-get install -y --no-install-recommends make && \
    apt-get install -y --no-install-recommends curl


# install chrome for default testem config (as of ember-cli 2.15.0)
RUN apt-get install -y wget && \
    wget -q https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    apt-get install -y ./google-chrome-stable_current_amd64.deb

# install ember-cli
RUN \
	npm install -g ember-cli@4.5.0


CMD ["/bin/bash"]