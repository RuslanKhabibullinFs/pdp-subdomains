class RequestTimeLoggerMiddleware
  attr_reader :app
  private :app

  def initialize(app)
    @app = app
  end

  def call(env)
    requiest_start = Time.current

    status, header, body = app.call env

    request_end = Time.current

    Rails.logger.debug "Request response time is #{request_end - requiest_start} seconds"

    [status, header, body]
  end
end
