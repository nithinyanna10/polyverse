FROM ruby:3.2-alpine

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 8084

CMD ["ruby", "app.rb"]

