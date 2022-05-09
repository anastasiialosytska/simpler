require_relative 'router/route'

module Simpler
  class Router

    def initialize
      @routes = []
    end

    def get(path, root_point)
      add_route(:get, path, root_point)
    end

    def post(path, root_point)
      add_route(:post, path, root_point)
    end

    def route_for(env)
      method = env['REQUEST_METHOD'].downcase.to_sym
      path = env['PATH_INFO']

      @routes.find { |route| route.match?(method, path) }
    end

    private

    def add_route(method, path, root_point)
      root_point = root_point.split('#')
      action = root_point[1]
      controller = controller_from_string(root_point[0])
      route = Route.new(method, path, controller, action)

      @routes.push(route)
    end

    def controller_from_string(controller_name)
      Object.const_get("#{controller_name.capitalize}Controller")
    end
  end
end
