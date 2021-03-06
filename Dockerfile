FROM java:openjdk-8u111-jdk

LABEL maintainer "Gary A. Stafford <garystafford@rochester.rr.com>"

ENV REFRESHED_AT 2017-01-23

RUN set -ex \
  && apt-get -y update \
  && apt-get -y upgrade \
  && apt-get -y install git \
  && mkdir /candidate \
  && git clone --depth 1 --branch build-artifacts \
      "https://github.com/garystafford/candidate-service.git" \
      /candidate

RUN set -ex \
  && cd /candidate \
  && mv candidate-service-*.jar candidate-service.jar

CMD ["java", "-Dspring.profiles.active=docker-development", "-Djava.security.egd=file:/dev/./urandom", "-jar", "candidate/candidate-service.jar"]
