require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class OclintJsonCompilationDatabaseHelper
      # class methods that you define here become available in your action
      # as `Helper::OclintJsonCompilationDatabaseHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the oclint_json_compilation_database plugin helper!")
      end
    end
  end
end
