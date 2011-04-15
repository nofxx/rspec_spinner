begin
  require 'spec'
rescue LoadError
  require 'rubygems'
  gem 'rspec'
  require 'rspec'
end
require 'rspec_spinner'

config = RSpec.configuration
# we want to use colored output for the console, right?
config.color_enabled = true
documentation_formatter = config.send(:built_in_formatter, :documentation).new(config.output)
custom_formatter = RspecSpinner::Spinner.new(STDOUT)
config.instance_variable_set(:@reporter, RSpec::Core::Reporter.new(documentation_formatter, custom_formatter))

$:.unshift(File.dirname(__FILE__) + '/../lib')
