require_relative "./router/mapper"
require_relative "./router/route"
require 'json'

class FrontController
  # The front controller is responsible for receiving all 
  # incoming HTTP request, after receiving it, it checked the
  # matched routes and call the appropriate controller action

  def handle(request_method, path, req)
  
    route = $registry.match(request_method, path)

    if route.nil?
      [404, {}, ["#{path} not found "]]
    else
      action = route[:action]

      controller = Object.const_get(route[:controller])

      instance = controller.new
      instance.url_params = req.params
      instance.params = route[:params]
 
      instance.send(action)
    end
  end
end
