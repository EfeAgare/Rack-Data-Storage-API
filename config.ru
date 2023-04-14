require_relative 'server'


app = Rack::Builder.new do
  # Define a global hash table to store the objects
  $data = {}

  use Rack::Reloader
  run Server.new
end.to_app

run app
