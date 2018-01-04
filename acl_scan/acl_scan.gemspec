$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "acl_scan/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "acl_scan"
  s.version     = AclScan::VERSION
  s.authors     = ["BigBing"]
  s.email       = ["1075264520@qq.com"]
  s.homepage    = ""
  s.summary     = "Summary of AclScan."
  s.description = "Description of AclScan."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.1.4"

  s.add_development_dependency "sqlite3"
end
