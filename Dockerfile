FROM ruby:2.5.1

RUN apt update
RUN apt install -y qt5-default libqt5webkit5-dev software-properties-common
RUN apt-add-repository "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main"
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN apt update
RUN apt install -y libpq-dev

ENV APP_HOME /home/rtg
ENV BUNDLE_PATH /usr/local/bundle
VOLUME /home/rtg
VOLUME /usr/local/bundle
CMD bundle exec rails server
WORKDIR ${APP_HOME}
