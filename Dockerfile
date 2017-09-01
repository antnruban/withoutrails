FROM ruby:2.4.1

RUN apt-get update && apt-get install -y build-essential

ENV APP_PATH /usr/src/app
RUN mkdir -p ${APP_PATH}
WORKDIR ${APP_PATH}

RUN gem install \
  bundler \
  rake \
  rubocop \
  pry

CMD ["bash"]

EXPOSE 3000
