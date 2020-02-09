FROM jenkins/jenkins:lts


# Installing cmake
USER root
RUN apt-get update && apt-get install -y cmake
# drop back to the regular jenkins user - good practice
# USER jenkins