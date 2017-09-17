# Local development

### Required software

* Ruby 2.4.1
* Ruby on Rails 5.1.3
* Postgresql 9.3 or later

### Database setup

```shell
bin/rake db:setup
```

### Test Data setup

```shell
bin/rake dev:generate_data
```

### Run Unit Tests/Specs

```shell
bundle exec rspec
```
