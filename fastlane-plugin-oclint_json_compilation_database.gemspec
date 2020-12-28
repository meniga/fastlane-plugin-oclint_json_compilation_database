# coding: utf-8

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fastlane/plugin/oclint_json_compilation_database/version'

Gem::Specification.new do |spec|
  spec.name          = 'fastlane-plugin-oclint_json_compilation_database'
  spec.version       = Fastlane::OclintJsonCompilationDatabase::VERSION
  spec.author        = 'Meniga'
  spec.email         = 'mobile.dev@meniga.com'

  spec.summary       = 'Run OCLint validation with oclint-json-compilation-database and fastlane :dart: :rocket:'
  spec.homepage      = "https://github.com/meniga/fastlane-plugin-oclint_json_compilation_database"
  spec.license       = "MIT"

  spec.files         = Dir["lib/**/*"] + %w(README.md LICENSE)
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  # Don't add a dependency to fastlane or fastlane_re
  # since this would cause a circular dependency

  # spec.add_dependency 'your-dependency', '~> 1.0.0'

  spec.add_development_dependency('pry')
  spec.add_development_dependency('bundler')
  spec.add_development_dependency('rspec')
  spec.add_development_dependency('rspec_junit_formatter')
  spec.add_development_dependency('rake')
  spec.add_development_dependency('rubocop', '1.7.0')
  spec.add_development_dependency('rubocop-require_tools')
  spec.add_development_dependency('simplecov')
  spec.add_development_dependency('fastlane', '>= 2.146.1')
end
