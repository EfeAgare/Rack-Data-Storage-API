require "minitest/autorun"

require_relative '../src/router/route'
require_relative '../src/router/registry'

class RouteTest < Minitest::Test

  def test_correct_route

    @home_route = Router::Route.draw do 
       get "/", "HomeController#home"
    end

    assert_instance_of Router::Attributes, @home_route.last

    assert_equal @home_route.last.path, "/"
  end  
end
