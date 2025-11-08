# Logging middleware
module Middleware
  class Logger
    def initialize(app)
      @app = app
    end
    
    def call(env)
      start_time = Time.now
      status, headers, body = @app.call(env)
      duration = Time.now - start_time
      
      log_request(env, status, duration)
      
      [status, headers, body]
    end
    
    private
    
    def log_request(env, status, duration)
      puts "[#{Time.now}] #{env['REQUEST_METHOD']} #{env['PATH_INFO']} - #{status} (#{duration}s)"
    end
  end
end

