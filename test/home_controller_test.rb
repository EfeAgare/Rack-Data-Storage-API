require "minitest/autorun"
require 'rack/test'

require_relative '../server'

class HomeControllerTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Server.new
  end

  def test_index
    get "/"
    assert_equal 200, last_response.status
    assert_equal "Welcome to the Rack Application", last_response.body
  end
end
