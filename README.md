# Local development

### Required software

* Ruby 2.4.1
* Ruby on Rails 5.1.3
* Postgresql 9.3 or later

### Database setup

```shell
bin/rails db:setup
```

### Test Data setup

```shell
bin/rails dev:generate_data

# You can specify arguments
bin/rails 'dev:generate_data[100,10,20]'
```

### Run Unit Tests/Specs

```shell
bundle exec rspec
```
