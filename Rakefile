%w[rubygems rake rake/clean fileutils newgem rubigen].each { |f| require f }
require File.dirname(__FILE__) + '/lib/rspec_spinner'

# Generate all the Rake tasks
# Run 'rake -T' to see list of generated tasks (from gem root directory)
$hoe = Hoe.new('rspec_spinner', RspecSpinner::VERSION) do |p|
  p.developer('Marcos Piccinini', 'x@nofxx.com')
  p.summary = "Some extra formatters for rspec"
  p.description = "Some extra formatters for rspec"
  p.url = "http://github.com/nofxx/postgis_adapter"
  p.changes              = p.paragraphs_of("History.txt", 0..1).join("\n\n")
  p.post_install_message = 'PostInstall.txt' 
  p.rubyforge_name       = p.name # TODO this is default value
  p.extra_deps         = [
     ['rspec','>=1.1.11'],
     ['rtui','>= 0.0.2']
  ]
  p.extra_dev_deps = [
    ['newgem', ">= #{::Newgem::VERSION}"]
  ]
  
  p.clean_globs |= %w[**/.DS_Store tmp *.log]
  path = (p.rubyforge_name == p.name) ? p.rubyforge_name : "\#{p.rubyforge_name}/\#{p.name}"
  p.remote_rdoc_dir = File.join(path.gsub(/^#{p.rubyforge_name}\/?/,''), 'rdoc')
  p.rsync_args = '-av --delete --ignore-errors'
end

require 'newgem/tasks' # load /tasks/*.rake
Dir['tasks/**/*.rake'].each { |t| load t }

# TODO - want other tests/tasks run by default? Add them to the list
# task :default => [:spec, :features]
