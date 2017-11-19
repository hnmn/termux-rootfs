# -*- encoding: utf-8 -*-
# stub: google-protobuf 3.4.1 ruby lib
# stub: ext/google/protobuf_c/extconf.rb

Gem::Specification.new do |s|
  s.name = "google-protobuf".freeze
  s.version = "3.4.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Protobuf Authors".freeze]
  s.date = "2017-09-18"
  s.description = "Protocol Buffers are Google's data interchange format.".freeze
  s.email = "protobuf@googlegroups.com".freeze
  s.extensions = ["ext/google/protobuf_c/extconf.rb".freeze]
  s.files = ["ext/google/protobuf_c/extconf.rb".freeze]
  s.homepage = "https://developers.google.com/protocol-buffers".freeze
  s.licenses = ["BSD-3-Clause".freeze]
  s.rubygems_version = "2.6.13".freeze
  s.summary = "Protocol Buffers".freeze

  s.installed_by_version = "2.6.13" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake-compiler-dock>.freeze, ["~> 0.6.0"])
      s.add_development_dependency(%q<rake-compiler>.freeze, ["~> 0.9.5"])
      s.add_development_dependency(%q<test-unit>.freeze, [">= 3.0.9", "~> 3.0"])
      s.add_development_dependency(%q<rubygems-tasks>.freeze, ["~> 0.2.4"])
    else
      s.add_dependency(%q<rake-compiler-dock>.freeze, ["~> 0.6.0"])
      s.add_dependency(%q<rake-compiler>.freeze, ["~> 0.9.5"])
      s.add_dependency(%q<test-unit>.freeze, [">= 3.0.9", "~> 3.0"])
      s.add_dependency(%q<rubygems-tasks>.freeze, ["~> 0.2.4"])
    end
  else
    s.add_dependency(%q<rake-compiler-dock>.freeze, ["~> 0.6.0"])
    s.add_dependency(%q<rake-compiler>.freeze, ["~> 0.9.5"])
    s.add_dependency(%q<test-unit>.freeze, [">= 3.0.9", "~> 3.0"])
    s.add_dependency(%q<rubygems-tasks>.freeze, ["~> 0.2.4"])
  end
end
