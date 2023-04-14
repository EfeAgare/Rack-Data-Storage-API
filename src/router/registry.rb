require_relative './attributes'
require 'pry'
module Router
  class Registry
    attr_reader :routes
    def initialize
      @routes = []
    end

    def add(request_method, path, to_controller)
      route = Attributes.new(request_method, path, to_controller)
      @routes << route
    end
    
    def match(request_method, path)

      match_method = @routes.select{|route| route.request_method.upcase.eql?(request_method)}
      
      route_params = {}
      
      match_method.each do |route|
  
        path_array = path.split("/")
        route_path_array = route.path.split('/')
        next unless path_array.size.eql?(route_path_array.size)
        
        if path =~ %r{^/data/(?<repository>[^/]+)/(?<object_id>[^/]+)/?$}
            match_data = $~ # $~ holds the MatchData object for the last successful match
            params = keys_to_sym(match_data.named_captures)
            name, action = name_and_action(route.controller)
        elsif path =~ %r{^/data/(?<repository>[^/]+)/?$}
            match_data = $~
            params = keys_to_sym(match_data.named_captures)
            name, action = name_and_action(route.controller)
        else path != %r{^/data/(?<repository>[^/]+)/?$}
          name, action = name_and_action(route.controller)
        end

        route_params = {
          params: params,
          controller: name,
          action: action
        }
      end

      route_params
    end

    def keys_to_sym(match_data)
      result = {}
      match_data.each_pair do |key, value|
        result[key.to_sym] = value
      end
      result
    end

    def name_and_action(to)
      to.split('#')
    end
    
    ["get", "post", "put", "delete"].each do |method|

      define_method(method) do |path, to_controller|
        add method, path, to_controller
      end
    end
  end
end
