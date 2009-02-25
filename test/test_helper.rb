begin
  require 'shoulda'
rescue LoadError
  warn 'To run the test suite, you need the Shoulda gem:'
  warn '$ sudo gem install thoughtbot-shoulda'
  exit 1
end

begin
  require 'mocha'
rescue LoadError
  warn 'To run the test suite, you need the Mocha gem:'
  warn '$ sudo gem install mocha'
  exit 1
end

require 'test/unit'
require 'whenever'

module TestExtensions
  def two_hours
    "0 0,2,4,6,8,10,12,14,16,18,20,22 * * *"
  end
end

class Test::Unit::TestCase
  include TestExtensions
end
