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

