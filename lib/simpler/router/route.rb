require 'byebug'

module Simpler
  class Router
    class Route

      attr_reader :controller, :action, :params

      def initialize(method, path, controller, action)
        @method = method
        @path = path
        @controller = controller
        @action = action
        @params = {}
      end

      def match?(method, path)
        @method == method && path.match(path_to_route)
      end

      def add_params(path)
        value = path.scan(/\w+\/\d+/).join('/')

        value = value.split('/')
        params[:id] = value.last.to_i
      end

      private

      def path_to_route
        Regexp.new("^#{@path.gsub(/:id/, '\d+')}$")
      end

    end
  end
end

