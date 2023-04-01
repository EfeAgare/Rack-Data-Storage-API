module Router
  class Attributes
    attr_reader :path, :request_method, :controller

    def initialize(request_method, path, controller)
      @request_method = request_method
      @path = path
      @controller = controller
    end
  end
end
