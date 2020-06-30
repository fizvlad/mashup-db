# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## Credetionals

Setup credetionals for your environment (`development`, `test` or `production`) with:

```
$ rails credentials:edit --environment ENV
```

Sometime you would need to setup folowing variables:
* `EDITOR=notepad`

Credetionals example in YAML (production config should also contain `secret_key_base` string, which can be generated with `rake secret`):

```
db:
  login: lgn
  password: psswrd
vk:
  api_key: key
```

Credetionals will be encoded and indexed by git. Decoding is performed during runtime using `config/master.key`.
You will be able to access credetionals through `Rails.application.credentials` object.

## Running tests

Change `RAILS_ENV` environment variable to `test`, then

```
$ rake test
```

## Running server

### Development

Separately run Webpack server...

```
$ ruby bin/webpack-dev-server
```

... and Rails server

```
$ rails s -e development -b 0.0.0.0 -p 3000
```

### Production

#### On dedicated machine

Setup environment variables:
* `RAILS_ENV=production`
* `RAILS_SERVE_STATIC_FILES=true` unless NGINX or apache is used (see https://github.com/rails/webpacker/issues/1249)

Precompile assets:

```
$ rake assets:precompile
```

Optionally, you should migrate:

```
$ rails db:migrate
```

Run in production:

```
$ rails s -e production -b 0.0.0.0 -p 3000
```

#### Via Heroku

Make sure to login into CLI:

```
$ heroku login
```
