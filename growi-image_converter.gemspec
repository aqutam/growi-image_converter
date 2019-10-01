# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'growi/image_converter/version'

Gem::Specification.new do |spec|
  spec.name          = 'growi-image_converter'
  spec.version       = Growi::ImageConverter::VERSION
  spec.authors       = ['Takayuki TAMURA']
  spec.email         = ['tamtam.okinawa@gmail.com']

  spec.summary       = 'GROWI image converter'
  spec.description   = 'growi-image_converter is a converter that converts esa.io image to growi.'
  spec.homepage      = 'https://github.com/aqutam/growi-image-converter-esa'
  spec.license       = 'MIT'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_dependency 'growi-client'
end
