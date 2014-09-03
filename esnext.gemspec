Gem::Specification.new do |s|
  s.name    = 'esnext'
  s.version = '0.10.0'

  s.homepage    = "https://github.com/esnext/ruby-esnext"
  s.summary     = "esnext compiler for Ruby"
  s.description = <<-EOS
    Ruby esnext is a bridge to the JS esnext compiler.
  EOS
  s.license = "MIT"

  s.files = [
    'lib/esnext.rb',
    'vendor/esnext.js',
    'LICENSE',
    'README.md'
  ]

  s.add_dependency 'execjs'
  s.add_development_dependency 'rake'

  s.authors = ['Brian Donovan']
  s.email   = 'me@brian-donovan.com'
end
