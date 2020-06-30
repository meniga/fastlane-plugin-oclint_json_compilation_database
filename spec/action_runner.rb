module ActionRunner
  def self.oclint_json_compilation_database(string_params)
    run_action("oclint_json_compilation_database", string_params)
  end

  def self.run_action(name, string_params)
    Fastlane::FastFile.new.parse("
      lane :test do
        #{name}(#{string_params})
      end
      ").runner.execute(:test)
  end
end
