FROM ruby:3.2.2

RUN curl -sL https://deb.nodesource.com/setup_20.x | bash - && \
  apt-get update -qq && \
  apt-get install -y nodejs && \
  npm install -g yarn

RUN apt-get update -qq && apt-get install -y --no-install-recommends libvips42

WORKDIR /app

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

RUN bundle install

COPY package.json /app/package.json
COPY yarn.lock /app/yarn.lock

RUN yarn install

COPY . /app

RUN yarn build

CMD ["rails", "server", "-b", "0.0.0.0"]
