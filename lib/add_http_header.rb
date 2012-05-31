require 'active_support'
require 'active_support/core_ext'

# Rack middleware to add arbitrary HTTP headers to responses.
class AddHttpHeader
  # Initialize with the headers to add. Headers should be a hash. The headers are added after the request
  # is processed. The values of the headers hash can be Proc objects in which case they are called with the
  # request environment, response status, and response headers at runtime. In this way, you can add dynamic
  # values as headers.
  def initialize (app, headers)
    @app = app
    @headers = headers
  end

  def call (env)
    status, headers, body = @app.call(env)
    @headers.each_pair do |name, value|
      value = value.call(env, status, headers) if value.is_a?(Proc)
      headers[name.to_s] = value.to_s unless value.blank?
    end
    return [status, headers, body]
  end
end
