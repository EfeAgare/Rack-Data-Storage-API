require_relative './app_controller'
class HomeController < AppController
  def index
    render "Welcome to the Rack Application"
  end
end
