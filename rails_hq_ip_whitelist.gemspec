# frozen_string_literal: true

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ip_whitelist/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_hq_ip_whitelist"
  s.version     = IPWhitelist::VERSION
  s.authors     = ["Brendan Carney"]
  s.email       = ["brendan@onehq.com"]
  s.homepage    = "https://github.com/onehq/rails_hq_ip_whitelist"
  s.summary     = "Whitelist IP Addresses"
  s.description = "Whitelist IP Addresses"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails",                              "~> 6.0"
  s.add_dependency "sorbet-runtime",                     "~> 0.0"

  s.add_development_dependency "sorbet",                 "~> 0.0"
  s.add_development_dependency "testhq",                 "~> 2.0"
end
