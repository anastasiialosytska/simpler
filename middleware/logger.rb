require 'logger'

class AppLogger

  def initialize(app, **options)
    @logger = Logger.new(options[:logdev] || STDOUT)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)
    @logger.info(message(env, status, headers))
    [status, headers, response]
  end

  def message(env, status, headers)
    "\nRequest: #{env['REQUEST_METHOD']} #{env['PATH_INFO']}
    Handler: #{env['simpler.controller'].class}##{env['simpler.action']}
    Parameters: #{env['simpler.params']}
    Response: #{status} [#{headers['Content-Type']}] #{env['simpler.controller']&.name}/#{env['simpler.action']}.html.erb"
  end

end
