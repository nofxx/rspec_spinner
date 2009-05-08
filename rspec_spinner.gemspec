# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec_spinner}
  s.version = "0.5.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcos Augusto"]
  s.date = %q{2009-05-08}
  s.email = %q{Cool Extra formatters for Rspec}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "History.txt",
     "MIT-LICENSE",
     "PostInstall.txt",
     "README.rdoc",
     "Rakefile",
     "lib/rspec_spinner.rb",
     "lib/rspec_spinner/bar.rb",
     "lib/rspec_spinner/base.rb",
     "lib/rspec_spinner/spinner.rb",
     "rspec_spinner.gemspec",
     "spec/rspec_spinner/base_spec.rb",
     "spec/rspec_spinner/spinner_spec.rb",
     "spec/rspec_spinner_spec.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/nofxx/rspec_spinner}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.2}
  s.summary = %q{Extra formatters for Rspec}
  s.test_files = [
    "spec/rspec_spinner/spinner_spec.rb",
     "spec/rspec_spinner/base_spec.rb",
     "spec/spec_helper.rb",
     "spec/rspec_spinner_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, [">= 0"])
      s.add_runtime_dependency(%q<rtui>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<rtui>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<rtui>, [">= 0"])
  end
end
