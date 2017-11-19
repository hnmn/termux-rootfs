# -*- encoding: utf-8 -*-
# stub: rbnacl 4.0.2 ruby lib

Gem::Specification.new do |s|
  s.name = "rbnacl".freeze
  s.version = "4.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Tony Arcieri".freeze, "Jonathan Stott".freeze]
  s.date = "2017-03-13"
  s.description = "The Networking and Cryptography (NaCl) library provides a high-level toolkit for building cryptographic systems and protocols".freeze
  s.email = ["bascule@gmail.com".freeze, "jonathan.stott@gmail.com".freeze]
  s.homepage = "https://github.com/cryptosphere/rbnacl".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 2.2.6".freeze)
  s.rubygems_version = "2.6.13".freeze
  s.summary = "Ruby binding to the Networking and Cryptography (NaCl) library".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, [">= 0"])
    else
      s.add_dependency(%q<ffi>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<ffi>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, [">= 0"])
  end
end
