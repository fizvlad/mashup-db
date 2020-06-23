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

