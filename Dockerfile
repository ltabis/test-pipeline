# Jenkins image.
FROM jenkins/jenkins:lts

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

# # Just in case.
RUN cmake --version   

# drop back to the regular jenkins user - good practice.
# USER jenkins