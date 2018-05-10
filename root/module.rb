require 'sinatra/base'
require 'sinatra/extension'
require 'sinatra/json'
require 'byebug' if Sinatra::Base.development?

class Root < Sinatra::Base

  set logging: true
  set dump_errors: true
  
  # Output request details for debugging in development
  before do
    log "\nRequest:\n #{request.request_method}\n #{request.path_info}\n"
  end

  def log(text)
    STDOUT.puts text
  end

  not_found do
    return 404, "Not a valid route. Does not map to a module."
  end

end
