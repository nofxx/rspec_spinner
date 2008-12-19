# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rspec_spinner}
  s.version = "0.3.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Marcos Piccinini"]
  s.date = %q{2008-12-19}
  s.description = %q{Some extra formatters for rspec}
  s.email = ["x@nofxx.com"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/nofxx/postgis_adapter}
  s.post_install_message = %q{PostInstall.txt}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rspec_spinner}
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Some extra formatters for rspec}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, [">= 1.1.11"])
      s.add_runtime_dependency(%q<rtui>, [">= 0.0.2"])
      s.add_development_dependency(%q<newgem>, [">= 1.1.0"])
      s.add_development_dependency(%q<hoe>, [">= 1.8.0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.1.11"])
      s.add_dependency(%q<rtui>, [">= 0.0.2"])
      s.add_dependency(%q<newgem>, [">= 1.1.0"])
      s.add_dependency(%q<hoe>, [">= 1.8.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.1.11"])
    s.add_dependency(%q<rtui>, [">= 0.0.2"])
    s.add_dependency(%q<newgem>, [">= 1.1.0"])
    s.add_dependency(%q<hoe>, [">= 1.8.0"])
  end
end
