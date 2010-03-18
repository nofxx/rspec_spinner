require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "rspec_spinner"
    gem.summary = "Extra formatters for Rspec"
    gem.email = "Cool Extra formatters for Rspec"
    gem.homepage = "http://github.com/nofxx/rspec_spinner"
    gem.authors = ["Marcos Augusto"]
    gem.add_dependency 'rtui'
    gem.add_development_dependency 'rspec'
    gem.post_install_message = <<-POST_INSTALL_MESSAGE

50% |========= RSPEC_SPINNER =========|

Require it on spec/spec_helper.rb:

  require 'spec'
  require 'rspec_spinner'
  ...

Change your spec.opts --format to:

  --format RspecSpinner::Bar

or:

  --format RspecSpinner::Spinner

Have fun!

POST_INSTALL_MESSAGE
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/*_test.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "rspec_spinner #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

