# Log analytics

Kata to process dummy log files and show the most visited pages in descending order.
It also show the unique page visits in descending order.

## Install dependencies
```bash
bundle install
```

## Running tests
```bash
bundle exec rspec
```

## Running the parser
```bash
bin/analyse.sh test.log
bin/analyse.sh webserver.log

ruby parser.rb test.log
ruby parser.rb webserver.log
```
