require_relative './mapper'
require_relative './registry'

module Router
  class Route
    def self.draw(&block)
      $registry = Registry.new
      mapper = Mapper.new($registry)
      mapper.draw(&block)
    end
  end
end