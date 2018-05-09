require 'sinatra/base'
require 'sinatra/extension'
require 'sinatra/json'
require 'byebug' if Sinatra::Base.development?

class Root < Sinatra::Base

  # Output request details for debugging in development
  before do
    log "\nRequest:\n #{request.query_string}\n #{request.body.rewind; request.body.read}\n #{request.request_method}\n #{request.path_info}\n #{params.inspect}"
  end

  def log(text)
    STDOUT.puts text
  end

  not_found do
    return 404, "Not a valid route. Does not map to a module."
  end

end
