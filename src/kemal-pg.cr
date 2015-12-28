require "pg"
require "pool/connection"
require "http"

macro conn
  env.request.pg.not_nil!.connection
end

macro release
  env.request.pg.not_nil!.release
end

def pg_connect(conn_url, capacity = 25, timeout = 0.1)
  Kemal.config.add_handler Kemal::PG.new(conn_url, capacity, timeout)
end

class HTTP::Request
  property pg
end

class Kemal::PG < HTTP::Handler
  def initialize(conn_url, capacity, timeout)
    @pg = ConnectionPool.new(capacity: capacity, timeout: timeout) do
      ::PG.connect(conn_url)
    end
  end

  def call(request)
    request.pg = @pg
    call_next(request)
  end
end
