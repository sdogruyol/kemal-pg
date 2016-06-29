require "pg"
require "pool/connection"
require "http"

macro connection
  env.pg.connection
end

macro release
  env.pg.release
end

def pg_connect(conn_url, capacity = 25, timeout = 0.1)
  Kemal.config.add_handler Kemal::PG.new(conn_url, capacity, timeout)
end

class HTTP::Server::Context
  property! pg : ConnectionPool(PG::Connection)
end

class Kemal::PG < HTTP::Handler
  def initialize(conn_url, capacity, timeout)
    @pg = ConnectionPool(PG::Connection).new(capacity: capacity, timeout: timeout) do
      ::PG.connect(conn_url)
    end
  end

  def call(context)
    context.pg = @pg
    call_next(context)
  end
end
