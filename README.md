# kemal-pg

Postgresql connection middleware for [Kemal](https://github.com/sdogruyol/kemal)

## Installation


Add this to your application's `shard.yml`:

```yaml
dependencies:
  kemal-pg:
    github: sdogruyol/kemal-pg
```


## Usage

This middleware adds `Postgresql` connection pool to [Kemal](https://github.com/sdogruyol/kemal) as a middleware.

```crystal
require "kemal"
require "kemal-pg"

pg_connect "postgres://user@host:5432/your_db"

# Make sure to yield `env`.
get "/" do |env|
  users = conn.exec("SELECT * FROM users")
  # Be sure to release the connection after you're done
  pg.release
  "Hello from postgresql"
end
```

## Contributing

1. Fork it ( https://github.com/sdogruyol/kemal-pg/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [sdogruyol](https://github.com/sdogruyol) Sdogruyol - creator, maintainer
