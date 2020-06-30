require 'fastlane'

module Fastlane
  module Actions
    class OclintJsonCompilationDatabaseAction < Action
      def self.run(params)
        cmd = []
        cmd << (params[:executable] || "oclint-json-compilation-database").dup

        build_path = params[:build_path]
        if build_path
          cmd << '-p'
          cmd << build_path
        end

        include = Array(params[:include])
        include.each do |path|
          cmd << "--include"
          cmd << path
        end

        exclude = Array(params[:exclude])
        exclude.each do |path|
          cmd << "--exclude"
          cmd << path
        end

        oclint_args = []
        report_type = params[:report_type]
        if report_type
          oclint_args << "-report-type"
          oclint_args << report_type
        end

        oclint_args << "-enable-clang-static-analyzer" if params[:enable_clang_static_analyzer]

        if oclint_args.any?
          cmd << "--"
          cmd << oclint_args
        end

        report_path = params[:report_path]
        if report_path
          cmd << ">>"
          cmd << report_path
        end

        begin
          Actions.sh(cmd.join(' '))
        rescue
          handle_error(params[:ignore_exit_status])
        end
      end

      def self.handle_error(ignore_exit_status)
        if ignore_exit_status
          failure_suffix = 'which would normally fail the build.'
          secondary_message = 'fastlane will continue because the `ignore_exit_status` option was used! 🙈'
        else
          failure_suffix = 'which represents a failure.'
          secondary_message = 'If you want fastlane to continue anyway, use the `ignore_exit_status` option. 🙈'
        end

        UI.important("")
        UI.important("oclint-json-compilation-database finished with status code other than 0, #{failure_suffix}")
        UI.important(secondary_message)
        UI.important("")
        UI.user_error!("oclint-json-compilation-database finished with errors") unless ignore_exit_status
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :executable,
                                       env_name: 'FL_OCLJCD_EXECUTABLE',
                                       description: 'Path to the `oclint-json-compilation-database` executable on your machine',
                                       optional: true,
                                       type: String,
                                       verify_block: proc do |value|
                                         UI.user_error!("Couldn't find executable path '#{File.expand_path(value)}'") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :build_path,
                                       env_name: 'FL_OCLJCD_BUILD_PATH',
                                       description: 'Specify the directory containing compile_commands.json',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :include,
                                       env_name: 'FL_OCLJCD_INCLUDE',
                                       description: 'Extract files matching pattern',
                                       optional: true,
                                       type: Array),
          FastlaneCore::ConfigItem.new(key: :exclude,
                                       env_name: 'FL_OCLJCD_EXCLUDE',
                                       description: 'Remove files matching pattern',
                                       optional: true,
                                       type: Array),
          FastlaneCore::ConfigItem.new(key: :enable_clang_static_analyzer,
                                       env_name: 'FL_OCLJCD_EXCLUDE_ENABLE_CLANG_STATIC_ANALYZER',
                                       description: 'Enable Clang Static Analyzer, and integrate results into OCLint report',
                                       optional: true,
                                       default_value: false,
                                       type: Boolean),
          FastlaneCore::ConfigItem.new(key: :report_path,
                                       env_name: 'FL_OCLJCD_REPORT_PATH',
                                       description: 'The reports file path',
                                       optional: true,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :report_type,
                                       env_name: 'FL_OCLJCD_REPORT_TYPE',
                                       description: 'The type of the report. Available: text, html, xml, json, pmd, xcode',
                                       optional: true,
                                       type: String,
                                       verify_block: proc do |value|
                                         available = ['text', 'html', 'xml', 'json', 'pmd', 'xcode']
                                         UI.user_error!("Available values are '#{available.join("', '")}'") unless available.include?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :ignore_exit_status,
                                       env_name: "FL_OCLJCD_IGNORE_EXIT_STATUS",
                                       description: "Ignore the exit status of the oclint-json-compilation-database command, so that serious violations \
                                                     don't fail the build (true/false)",
                                       default_value: false,
                                       type: Boolean,
                                       optional: true)

        ]
      end

      def self.category
        :testing
      end

      def self.is_supported?(_platform)
        true
      end

      def self.authors
        ["Marcin Stepnowski"]
      end
    end
  end
end
