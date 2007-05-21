%w(spec).each { |r| require r }
require File.dirname(__FILE__) + '/../lib/restflection'

Spec::Runner.configure do |config|
  config.mock_with :mocha
end

module SharedStubs
  def controller_stub(stub_these = {})
    @controller ||= stub(stub_these)
  end

  def reflection_stub
    @reflection ||= stub
  end

  def view_stub
    @view ||= stub(:controller => controller_stub)
  end
end
