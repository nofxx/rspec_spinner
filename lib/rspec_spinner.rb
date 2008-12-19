$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
#require "spec/runner/options"
require "rspec_spinner/base"
require "rspec_spinner/spinner"
require "rspec_spinner/bar"

module RspecSpinner
  VERSION = '0.2.8'
end

#module Spec
#  module Runner
#    class Options
#      EXAMPLE_FORMATTERS.merge({ 'spinner'  => ['spec/runner/formatter/spinner_formatter',                'Formatter::SpinnerFormatter'] })
#    end
##  end
#end