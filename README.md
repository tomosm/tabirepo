<!--[![Analytics](https://ga-beacon.appspot.com/UA-84540030-1/welcome-page)](https://github.com/tomosm/tabirepo)-->


旅レポ: TabiRepo
=============

[旅レポ: TabiRepo](https://github.com/tomosm/tabirepo)

## Description
This was an unsuccessful web media launched in 2013 and is in the end of service.

## Demo

## Requirement
### Database

- SQLite or MySQL 5.5+

### Ruby
Ruby Version 1.9+
Ruby on Rails 3.2

### Web Browser

- Firefox - Latest Version
- Chrome - Latest Version
- Safari - Latest Version
- Internet Explorer - IE 9+

## Install
### Gems
bundle install --path vendor/bundle

### DB load
bundle exec rake db:create
bundle exec rake db:schema:load
bundle exec rake db:migrate
bundle exec rake db:seed

### Start Rails App 
bundle exec rails s

## Licence

[MIT](https://opensource.org/licenses/MIT)

## Author

[tomosm](https://github.com/tomosm)
