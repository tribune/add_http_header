require 'rubygems'

begin
  require 'simplecov'
  SimpleCov.start do
    add_filter "/spec/"
  end
rescue LoadError
  # simplecov not installed
end

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'add_http_header'))

describe AddHttpHeader do
  
  before :each do
    @app = Proc.new{|env| [200, {"Content-Type" => "text/html"}, "Success"]}
  end
  
  it "should add headers to a request" do
    middleware = AddHttpHeader.new(@app, :test => "here", "x-Test" => 1)
    status, headers, body = middleware.call({})
    status.should == 200
    body.should == "Success"
    headers.should == {"Content-Type" => "text/html", "test" => "here", "x-Test" => "1"}
  end
  
  it "should add dynamic headers to a request" do
    middleware = AddHttpHeader.new(@app, :test => lambda{|env, status, headers| "#{env['HOST']} / #{status} / #{headers['Content-Type']}"})
    status, headers, body = middleware.call('HOST' => 'locahost')
    status.should == 200
    body.should == "Success"
    headers.should == {"Content-Type" => "text/html", "test" => "locahost / 200 / text/html"}
  end
  
  it "should not add blank headers" do
    middleware = AddHttpHeader.new(@app, :test => "")
    status, headers, body = middleware.call({})
    status.should == 200
    body.should == "Success"
    headers.should == {"Content-Type" => "text/html"}
  end

  it "doesn't add blank result of a dynamic header" do
    middleware = AddHttpHeader.new(@app, :test => ->(*){ "" })
    status, headers, body = middleware.call({})
    status.should == 200
    body.should == "Success"
    headers.should == {"Content-Type" => "text/html"}
  end
  
end
