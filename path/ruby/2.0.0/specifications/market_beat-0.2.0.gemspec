# -*- encoding: utf-8 -*-
# stub: market_beat 0.2.0 ruby lib

Gem::Specification.new do |s|
  s.name = "market_beat".freeze
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Michael Dvorkin".freeze]
  s.date = "2012-01-15"
  s.description = "Fetch real-time and delayed stock quotes and 100+ other financial and market indicaors from publicly available sources.".freeze
  s.email = "mike@dvorkin.net".freeze
  s.homepage = "http://github.com/michaeldv/market_beat".freeze
  s.rubyforge_project = "market_beat".freeze
  s.rubygems_version = "2.6.3".freeze
  s.summary = "Fetch up-to-date stock quotes and 100+ financial and market indicators.".freeze

  s.installed_by_version = "2.6.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>.freeze, [">= 2.6.0"])
    else
      s.add_dependency(%q<rspec>.freeze, [">= 2.6.0"])
    end
  else
    s.add_dependency(%q<rspec>.freeze, [">= 2.6.0"])
  end
end
