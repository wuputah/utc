require 'erb'

class App
  # load/cache the template
  def template
    @template ||= ERB.new(File.read(File.join(File.dirname(__FILE__), "index.html.erb")))
  end

  # eval the template
  def body(env)
    template.result(binding)
  end

  # main rack app
  def call(env)
    case env['HTTP_ACCEPT']
    when 'text/plain'
      [200, {"Content-type" => "text/plain"}, StringIO.new(Time.now.strftime("%Y-%m-%dT%H:%M:%S.%N%z"))]
    else
      [200, {"Content-type" => "text/html"}, StringIO.new(body(env))]
    end
  end
end

run App.new
