require_relative 'route'

Router::Route.draw do

  get '/', "HomeController#index"
  put '/data/:repository','DataController#upload'
  get '/data/:repository/:object_id', 'DataController#download'
  delete '/data/:repository/:object_id', 'DataController#delete'
end
