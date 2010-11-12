Gem::Specification.new do |s|
  s.name = 'actionmailer_with_request'
  s.version = '0.0.2'
  s.homepage = 'http://github.com/weppos/actionmailer_with_request'
  s.author = 'Simone Carletti'
  s.email = 'weppos@weppos.net'
  s.add_dependency 'rails', '>=3'
  s.files = Dir['lib/**/*.rb']
  s.has_rdoc = true
  s.extra_rdoc_files << 'README'
  s.rdoc_options << '--main' << 'README'
  s.summary = "Let's ActionMailer know about the website"
  s.description = <<-DESCRIPTION
    Let's ActionMailer know about the request context to avoid having
    to set a number of defaults manually.
  DESCRIPTION
end
