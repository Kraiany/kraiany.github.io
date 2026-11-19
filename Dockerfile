#
# Build: docker build -t kraiany .
#
# Develop:
#  docker run -it  --rm -v $(pwd):/app -p 4567:4567 kraiany
#  open http://localhost:4567
#
#
# Deploy:
# docker run -it  --rm -v $(pwd):/app -v ~/.gitconfig:/root/.gitconfig  -p 4567:4567 kraiany deploy
#
FROM ruby:3.4.13

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

WORKDIR /app

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    imagemagick \
    libmagickwand-dev \
    locales \
    nodejs \
  && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 4.0.9 \
  && bundle install --jobs 4 --retry 3

EXPOSE 4567

ENTRYPOINT ["bundle", "exec"]
CMD ["middleman", "server"]
