require_relative './registry'

module Router
 class Mapper
    def initialize(registry)
      @registry = registry
    end
    
    def draw(&block)
      instance_eval(&block)
    end
    
    def method_missing(method_name, *args)
      @registry.send(method_name, *args)
    end
  end
end
