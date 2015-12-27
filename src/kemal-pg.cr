require "pg"
require "pool/connection"
require "http"

macro pg_connect(conn_url)
  Kemal.config.add_handler Kemal::PG.new conn_url
end

class HTTP::Request
  property pg
end

class Kemal::PG < HTTP::Handler

  def initialize(conn_url)
    @pg = ConnectionPool.new(capacity: 25, timeout: 0.01) do
      PG.connect(conn_url)
    end
  end

  def call(request)
    request.pg = @pg
    call_next(request)
  end
end
