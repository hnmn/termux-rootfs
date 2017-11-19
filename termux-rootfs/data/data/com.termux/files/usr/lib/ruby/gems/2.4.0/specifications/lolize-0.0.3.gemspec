# -*- encoding: utf-8 -*-
# stub: lolize 0.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "lolize".freeze
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["miaout17".freeze]
  s.date = "2011-08-26"
  s.description = "Colorize your ruby stdout with Lolcat".freeze
  s.email = ["miaout17@gmail.com".freeze]
  s.homepage = "https://github.com/miaout17/lolize".freeze
  s.rubyforge_project = "lolize".freeze
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Colorize your ruby stdout with Lolcat".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<paint>.freeze, ["~> 0.8.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<paint>.freeze, ["~> 0.8.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<paint>.freeze, ["~> 0.8.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
