# -*- encoding: utf-8 -*-
# stub: active_record_tasks 1.0.4 ruby lib

Gem::Specification.new do |s|
  s.name = "active_record_tasks"
  s.version = "1.0.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Gilbert"]
  s.date = "2014-04-16"
  s.description = "Use ActiveRecord 4 in non-rails projects."
  s.email = ["gilbertbgarza@gmail.com"]
  s.homepage = "https://github.com/makersquare/active_record_tasks"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.2.2"
  s.summary = "The easiest way to get started with ActiveRecord 4 in a non-rails project."

  s.installed_by_version = "2.2.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 4.0"])
      s.add_runtime_dependency(%q<rake>, [">= 0"])
      s.add_runtime_dependency(%q<rainbow>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.3"])
    else
      s.add_dependency(%q<activerecord>, [">= 4.0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rainbow>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.3"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 4.0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rainbow>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.3"])
  end
end
