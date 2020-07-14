$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))

require 'simplecov'

SimpleCov.start

module SpecHelper
end

require 'fastlane'
require 'fastlane/plugin/oclint_json_compilation_database'
require 'action_runner.rb'

Fastlane.load_actions
