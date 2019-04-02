# Định nghĩa base image cần dùng tương ứng với ruby 2.6.1
FROM ruby:2.6.1
# Cài đặt một số package cần thiết cho ứng dụng Rails
RUN apt-get update && apt-get install -y build-essential nodejs
# Tạo và cấu hình thư mục làm việc chính.
# Các lệnh RUN, COPY, and ENTRYPOINT sau này sẽ được trỏ đến thư mục này.
RUN mkdir -p /app
WORKDIR /app

# Copy Gemfile, Gemfile.lock từ dự án và cài đặt sẵn các RubyGems trong images đươc build  
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v '1.17.3' && bundle install --jobs 20 --retry 5
# Copy source code vào trong image của app 
COPY . ./
# Mở cổng 3000 của docker host, có thể truy câp qua nó sau này
EXPOSE 3000
