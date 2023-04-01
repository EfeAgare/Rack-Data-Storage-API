#!/usr/bin/env ruby

require 'rack'
require 'json'

require_relative './src/front_controller'
require_relative './src/router/routes'

Dir.glob("src/controllers/**/*.rb").each{ |file_path|
  file_name = File.basename(file_path, ".rb")
  require_relative "./#{file_path}"
}


class Server
  def call(env)
    # the request path
    path = env['PATH_INFO']

    req = Rack::Request.new(env)
    request_method = env['REQUEST_METHOD']
    
    FrontController.new.handle request_method, path, req
  end
end

# This starts the server if the script is invoked from the command line. No
# modifications needed here.
if __FILE__ == $0
  app = Rack::Builder.new do
    # Define a global hash table to store the objects
    $data = {}

    use Rack::Reloader
    run Server.new
  end.to_app

  Rack::Server.start(app: app, Port: 8282)
end
