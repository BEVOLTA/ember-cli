FROM node:16-slim
MAINTAINER Fabien Foerster <f.foerster@bevolta.com>

RUN apt-get update && apt-get -y upgrade && apt-get install -y --no-install-recommends zip && apt-get install -y --no-install-recommends git && apt-get install -y --no-install-recommends make

# Install watchman build dependencies
RUN \
	apt-get update -y &&\
	apt-get install -y python-dev


# install watchman
# Note: See the README.md to find out how to increase the
# fs.inotify.max_user_watches value so that watchman will
# work better with ember projects.
RUN \
	git clone --branch=v4.9.0 --depth=1 https://github.com/facebook/watchman.git &&\
	cd watchman &&\
	./autogen.sh &&\
	CXXFLAGS=-Wno-error ./configure &&\
	make &&\
	make install

# install chrome for default testem config (as of ember-cli 2.15.0)
RUN \
    apt-get update &&\
    apt-get install -y \
        apt-transport-https \
        gnupg \
        --no-install-recommends &&\
	curl -sSL https://dl.google.com/linux/linux_signing_key.pub | apt-key add - &&\
	echo "deb [arch=amd64] https://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list &&\
	apt-get update &&\
	apt-get install -y \
	    google-chrome-stable \
	    --no-install-recommends

# tweak chrome to run with --no-sandbox option
RUN \
	sed -i 's/"$@"/--no-sandbox "$@"/g' /opt/google/chrome/google-chrome

# install ember-cli
RUN \
	npm install -g ember-cli@4.5.0


CMD ["/bin/bash"]