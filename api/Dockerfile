FROM ruby:2.7.3
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y nodejs yarn 
WORKDIR /api
COPY Gemfile Gemfile.lock /api/
EXPOSE 3000
RUN bundle install
ARG MONGO_URI
ENV MONGODB_URI=/${MONGO_URI}
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]