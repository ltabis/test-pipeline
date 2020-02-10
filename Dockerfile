# Jenkins image.
FROM jenkins/jenkins:latest

# Installing cmake.
USER root

# Update system.
RUN apt-get update \
    && apt-get upgrade -y

# Delete the default installed version of cmake.
# RUN apt-get purge cmake

# Exposing ports
EXPOSE 8080

# Installing gcc, g++, make and openssl.
RUN apt-get install -y gcc g++ make libssl-dev

# Getting the latest version of cmake.
RUN mkdir ~/temp \
    && cd ~/temp

RUN wget https://cmake.org/files/v3.16/cmake-3.16.4.tar.gz \
    && tar -xzvf cmake-3.16.4.tar.gz

# # Run binaries.
RUN cd cmake-3.16.4 \
    && ls -l \
    && ./bootstrap \
    && make -j4 \
    && make install

# Install GTest.
RUN apt-get install libgtest-dev -y \
    && cd /usr/src/googletest/googletest \
    && mkdir build \
    && cd build \
    && cmake .. \
    && make \
    && cp libgtest* /usr/lib/ \
    && cd .. \
    && rm -rf build \
    && mkdir /usr/local/lib/googletest \
    && ln -s /usr/lib/libgtest.a /usr/local/lib/googletest/libgtest.a \
    && ln -s /usr/lib/libgtest_main.a /usr/local/lib/googletest/libgtest_main.a

# Just in case.
RUN cmake --version   

# drop back to the regular jenkins user - good practice.
# USER jenkins