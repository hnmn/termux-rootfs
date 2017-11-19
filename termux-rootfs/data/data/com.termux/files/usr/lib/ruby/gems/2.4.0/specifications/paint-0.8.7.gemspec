# -*- encoding: utf-8 -*-
# stub: paint 0.8.7 ruby lib

Gem::Specification.new do |s|
  s.name = "paint".freeze
  s.version = "0.8.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Jan Lelis".freeze]
  s.date = "2017-09-13"
  s.description = "Terminal painter / no string extensions / 256 color support / effect support / define custom shortcuts / basic usage: Paint['string', :red, :bright]".freeze
  s.email = "mail@janlelis.de".freeze
  s.extra_rdoc_files = ["README.rdoc".freeze, "LICENSE.txt".freeze]
  s.files = ["LICENSE.txt".freeze, "README.rdoc".freeze]
  s.homepage = "https://github.com/janlelis/paint".freeze
  s.licenses = ["MIT".freeze]
  s.post_install_message = "       \u250C\u2500\u2500 info \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2510\n J-_-L \u2502 https://github.com/janlelis/paint \u2502\n       \u251C\u2500\u2500 usage \u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2524\n       \u2502 require 'paint'                   \u2502\n       \u2502 puts Paint['J-_-L', :red] # \e[31mJ-_-L\e[0m \u2502\n       \u2514\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2518".freeze
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7".freeze)
  s.rubygems_version = "2.6.11".freeze
  s.summary = "Terminal painter!".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<rspec-core>.freeze, [">= 0"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
      s.add_development_dependency(%q<rainbow>.freeze, ["= 1.1.4"])
      s.add_development_dependency(%q<term-ansicolor>.freeze, [">= 0"])
    else
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<rspec-core>.freeze, [">= 0"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
      s.add_dependency(%q<rainbow>.freeze, ["= 1.1.4"])
      s.add_dependency(%q<term-ansicolor>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<rspec-core>.freeze, [">= 0"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
    s.add_dependency(%q<rainbow>.freeze, ["= 1.1.4"])
    s.add_dependency(%q<term-ansicolor>.freeze, [">= 0"])
  end
end
