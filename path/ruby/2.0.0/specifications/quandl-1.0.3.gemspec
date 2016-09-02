# -*- encoding: utf-8 -*-
# stub: quandl 1.0.3 ruby lib

Gem::Specification.new do |s|
  s.name = "quandl".freeze
  s.version = "1.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Clement Leung".freeze, "Matthew Basset".freeze]
  s.date = "2015-09-16"
  s.description = "A ruby implementation of the quandl client to be used as an ORM for quandl's restful APIs.".freeze
  s.email = ["dev@quandl.com".freeze]
  s.homepage = "https://github.com/quandl/quandl-ruby".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "2.6.3".freeze
  s.summary = "An ORM interface into the quandl api.".freeze

  s.installed_by_version = "2.6.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 4.2.3"])
      s.add_runtime_dependency(%q<rest-client>.freeze, ["~> 1.8.0"])
      s.add_runtime_dependency(%q<json>.freeze, ["~> 1.8.3"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.10"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry-byebug>.freeze, ["~> 3.1.0"])
      s.add_development_dependency(%q<webmock>.freeze, ["~> 1.21.0"])
      s.add_development_dependency(%q<factory_girl>.freeze, ["~> 4.5.0"])
      s.add_development_dependency(%q<rubocopter>.freeze, [">= 0"])
    else
      s.add_dependency(%q<activesupport>.freeze, [">= 4.2.3"])
      s.add_dependency(%q<rest-client>.freeze, ["~> 1.8.0"])
      s.add_dependency(%q<json>.freeze, ["~> 1.8.3"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
      s.add_dependency(%q<pry-byebug>.freeze, ["~> 3.1.0"])
      s.add_dependency(%q<webmock>.freeze, ["~> 1.21.0"])
      s.add_dependency(%q<factory_girl>.freeze, ["~> 4.5.0"])
      s.add_dependency(%q<rubocopter>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>.freeze, [">= 4.2.3"])
    s.add_dependency(%q<rest-client>.freeze, ["~> 1.8.0"])
    s.add_dependency(%q<json>.freeze, ["~> 1.8.3"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<pry-byebug>.freeze, ["~> 3.1.0"])
    s.add_dependency(%q<webmock>.freeze, ["~> 1.21.0"])
    s.add_dependency(%q<factory_girl>.freeze, ["~> 4.5.0"])
    s.add_dependency(%q<rubocopter>.freeze, [">= 0"])
  end
end
