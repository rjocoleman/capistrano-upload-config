# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = 'capistrano-upload-config'
  spec.version       = '0.7.0'
  spec.authors       = 'Robert Coleman'
  spec.email         = 'github@robert.net.nz'
  spec.description   = %q{Capistrano 3.x tasks to upload shared config that is stored outside of SCM}
  spec.summary       = %q{Capistrano 3.x tasks to upload shared config that is stored outside of SCM}
  spec.homepage      = 'https://github.com/rjocoleman/capistrano-upload-config'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'capistrano', '>= 3.0'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
end
