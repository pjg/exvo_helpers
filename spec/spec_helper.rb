$:.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$:.unshift(File.dirname(__FILE__))

require 'exvo_helpers'

module Rails
end

RSpec.configure do |config|
  config.mock_with :rspec
end
