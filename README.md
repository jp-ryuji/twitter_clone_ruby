# Local development

### Required software

* Ruby 2.4.3
* Ruby on Rails 5.1.5
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

### Start local servers

```shell
bundle exec foreman start
=> You should access http://localhost:5000/

or

(on different tabs)
bin/rails server
bin/webpack-dev-server
```
