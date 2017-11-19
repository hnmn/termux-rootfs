# -*- encoding: utf-8 -*-
# stub: arel-helpers 2.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "arel-helpers".freeze
  s.version = "2.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Cameron Dutro".freeze]
  s.date = "2017-05-16"
  s.description = "Useful tools to help construct database queries with ActiveRecord and Arel.".freeze
  s.email = ["camertron@gmail.com".freeze]
  s.homepage = "http://github.com/camertron".freeze
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Useful tools to help construct database queries with ActiveRecord and Arel.".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>.freeze, ["< 6", ">= 3.1.0"])
    else
      s.add_dependency(%q<activerecord>.freeze, ["< 6", ">= 3.1.0"])
    end
  else
    s.add_dependency(%q<activerecord>.freeze, ["< 6", ">= 3.1.0"])
  end
end
