# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = "actionmailer-with-request"
  s.version     = "0.3.0"
  s.platform    = Gem::Platform::RUBY
  s.authors     = "Simone Carletti"
  s.email       = "weppos@weppos.net"
  s.homepage    = "http://github.com/weppos/actionmailer_with_request"
  s.summary     = "Let's ActionMailer know about the website."
  s.description = "Let's ActionMailer know about the request context to avoid having to set a number of defaults manually."

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 3"

  s.rdoc_options << "--main" << "README"
end
