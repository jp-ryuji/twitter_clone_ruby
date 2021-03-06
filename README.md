# Welcome

This repository has some features that twitter has as it's named. :-)
It also has the admin page (http://localhost:3000/admin), but it consists of sample code that intends to show how to write basic features such as search, csv import/export and so on. So the page is nothing to do with twitter.

Haven't payed much attention to the design/style for now.

## Caution

* This repository has some `NOTE` here and there. But they are for education purposes. You shouldn't mimic them when you write code for production.
* [`ridgepole`](https://github.com/winebarrel/ridgepole) is used instead of the Rails default db migration. `ridgepole` is especially useful where many developers are working on the same repository and many services are referring to the same database.

## Required software

* Ruby 2.5.0
* Ruby on Rails 5.1.6
* Postgresql 9.3 or later

## Local development
### Required software

The following software should be installed (by brew on Mac)
* yarn

### Getting Started

1. Install packages
    ```
    $ bundle install --path vendor/bundle
    ```
    ```
    $ yarn install
    ```

2. Database setup
    ```
    $ bin/rails db:create
    $ bundle exec rails ridgepole:apply
    ```

    ```
    # You should run the commands above intead of bin/rails db:setup as ridgepole is used.
    # You should pass RAILS_ENV, like RAILS_ENV=production, for an environment besides development as follows.
    $ bundle exec rails ridgepole:apply RAILS_ENV=production
    ```

3. Setup environment variables if needed (Maybe not. Skip the step if the yml file doesn't exist.)
    ```
    config/settings.yml
    ```

4. Start local servers
    ```
    $ bundle exec foreman start
    => You should access http://localhost:5000/

    or

    (Execute the following commands on different tabs)
    $ bin/rails server
    $ bin/webpack-dev-server
    ```

5. You have to sign up first from http://localhost:3000/signup to login.

6. If you want to create test data, see below.

### Run Specs (Tests)

```
$ bundle exec rspec
```

### Setup test data

```
$ bin/rails dev:generate_data

# You can specify arguments
$ bin/rails 'dev:generate_data[100,10,20]'

-> A test user is created with the following email and password (test@example.com / password).
```

### Overcommit

Setup overcommit for git hooks
```
$ bundle exec overcommit --install
$ bundle exec overcommit --sign
```

In case you have to ignore hooks
```
SKIP=HOOK COMMAND

e.g. SKIP=RuboCop git commit ...
e.g. OVERCOMMIT_DISABLE=1 git commit ...
```

### Rubocop

- [Disabling Cops within Source Code](https://github.com/rubocop-hq/rubocop/blob/master/manual/configuration.md#disabling-cops-within-source-code)

### Annotate

Until [this merge](https://github.com/ctran/annotate_models/pull/491) is released,
RuboCop raises 'Extra line detected'. Fix manually.

## Logging
[lograge](https://github.com/roidrage/lograge) is used. So the following command should be used instead of `Rails.logger`.

```ruby
LogrageLogger.call({ message: 'error message comes here' }, error: e)
```