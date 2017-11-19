# -*- encoding: utf-8 -*-
# stub: bettercap 1.6.1 ruby lib

Gem::Specification.new do |s|
  s.name = "bettercap".freeze
  s.version = "1.6.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Simone Margaritelli".freeze]
  s.date = "2017-06-29"
  s.description = "BetterCap is the state of the art, modular, portable and easily extensible MITM framework featuring ARP, DNS and ICMP spoofing, sslstripping, credentials harvesting and more.".freeze
  s.email = "evilsocket@gmail.com".freeze
  s.executables = ["bettercap".freeze]
  s.files = ["bin/bettercap".freeze]
  s.homepage = "https://github.com/evilsocket/bettercap".freeze
  s.licenses = ["GPL-3.0".freeze]
  s.rdoc_options = ["--charset=UTF-8".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9".freeze)
  s.rubygems_version = "2.6.11".freeze
  s.summary = "A complete, modular, portable and easily extensible MITM framework.".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<colorize>.freeze, ["~> 0.8.0"])
      s.add_runtime_dependency(%q<packetfu>.freeze, [">= 1.1.10", "~> 1.1"])
      s.add_runtime_dependency(%q<pcaprub>.freeze, ["<= 1.1.11", ">= 0.12.0", "~> 0.12"])
      s.add_runtime_dependency(%q<network_interface>.freeze, [">= 0.0.1", "~> 0.0"])
      s.add_runtime_dependency(%q<net-dns>.freeze, [">= 0.8.0", "~> 0.8"])
      s.add_runtime_dependency(%q<rubydns>.freeze, [">= 1.0.3", "~> 1.0"])
      s.add_runtime_dependency(%q<em-proxy>.freeze, [">= 0.1.8", "~> 0.1"])
    else
      s.add_dependency(%q<colorize>.freeze, ["~> 0.8.0"])
      s.add_dependency(%q<packetfu>.freeze, [">= 1.1.10", "~> 1.1"])
      s.add_dependency(%q<pcaprub>.freeze, ["<= 1.1.11", ">= 0.12.0", "~> 0.12"])
      s.add_dependency(%q<network_interface>.freeze, [">= 0.0.1", "~> 0.0"])
      s.add_dependency(%q<net-dns>.freeze, [">= 0.8.0", "~> 0.8"])
      s.add_dependency(%q<rubydns>.freeze, [">= 1.0.3", "~> 1.0"])
      s.add_dependency(%q<em-proxy>.freeze, [">= 0.1.8", "~> 0.1"])
    end
  else
    s.add_dependency(%q<colorize>.freeze, ["~> 0.8.0"])
    s.add_dependency(%q<packetfu>.freeze, [">= 1.1.10", "~> 1.1"])
    s.add_dependency(%q<pcaprub>.freeze, ["<= 1.1.11", ">= 0.12.0", "~> 0.12"])
    s.add_dependency(%q<network_interface>.freeze, [">= 0.0.1", "~> 0.0"])
    s.add_dependency(%q<net-dns>.freeze, [">= 0.8.0", "~> 0.8"])
    s.add_dependency(%q<rubydns>.freeze, [">= 1.0.3", "~> 1.0"])
    s.add_dependency(%q<em-proxy>.freeze, [">= 0.1.8", "~> 0.1"])
  end
end
