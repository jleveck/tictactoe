#!/bin/bash

cd /app/backend && (cmake --version || sudo apt-get update && sudo apt-get -y install cmake) &&
(sudo apt list --installed 2>/dev/null | grep 'libsqlite3-dev' || sudo apt-get update && sudo apt install libsqlite3-dev) &&
rm -f tmp/pids/server.pid &&
gem update --system &&
gem install bundler -v 2.1.2 &&
bundle install &&
bundle exec rails s -p 3001 -b '0.0.0.0' &
