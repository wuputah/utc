require 'rubygems'
require 'bundler'
require 'erb'

Bundler.require

# load/cache the template
def template
  @template ||= ERB.new(File.read(File.join(File.dirname(__FILE__), "index.html.erb")))
end

# eval the template
def body(env)
  @env = env
  @time = nil
  @request = Rack::Request.new(env)

  if custom = @request.params["t"]
    @time = Chronic.parse(custom)
  end

  @time ||= Time.now
  template.result(binding)
end

# main rack app
def app(env)
  [200, {"Content-type" => "text/html"}, body(env)]
end

run method(:app)
