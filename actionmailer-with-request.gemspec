# -*- encoding: utf-8 -*-
$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "actionmailer_with_request/version"

Gem::Specification.new do |s|
  s.name        = "actionmailer-with-request"
  s.version     = ActionMailerWithRequest::VERSION
  s.authors     = ["Simone Carletti"]
  s.email       = ["weppos@weppos.net"]
  s.homepage    = "https://github.com/weppos/actionmailer_with_request"
  s.summary     = "Let's ActionMailer know about the website"
  s.description = "Let's ActionMailer know about the request context to avoid having to set a number of defaults manually."

  s.require_paths = ["lib"]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.license       = 'MIT'

  s.add_dependency "rails", ">= 5"
end
