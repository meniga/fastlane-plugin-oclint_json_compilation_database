class MockError
end

describe Fastlane::Actions::OclintJsonCompilationDatabaseAction do
  describe 'oclint_json_compilation_database ' do
    before(:each) do
      expect(Fastlane::UI)
        .to receive(:success)
        .with("Driving the lane 'test' 🚀")
    end

    it 'should succed when shell command succed' do
      expect(Fastlane::Actions).to receive(:sh)
      expect(Fastlane::UI).not_to(receive(:user_error!))

      ActionRunner.oclint_json_compilation_database("")
    end

    it 'should succed when shell command fail when ignore_exit_status is true' do
      expect(Fastlane::Actions).to receive(:sh).and_raise(MockError.new)
      expect(Fastlane::UI).to receive(:important).with("")
      expect(Fastlane::UI)
        .to receive(:important)
        .with("oclint-json-compilation-database finished with status code other than 0, which would normally fail the build.")
      expect(Fastlane::UI)
        .to receive(:important)
        .with("fastlane will continue because the `ignore_exit_status` option was used! 🙈")
      expect(Fastlane::UI).to receive(:important).with("")
      expect(Fastlane::UI).not_to(receive(:user_error!))

      ActionRunner.oclint_json_compilation_database("ignore_exit_status: true")
    end

    it 'should fail when shell command fail when ignore_exit_status is false' do
      expect(Fastlane::Actions).to receive(:sh).and_raise(MockError.new)
      expect(Fastlane::UI).to receive(:important).with("")
      expect(Fastlane::UI)
        .to receive(:important)
        .with("oclint-json-compilation-database finished with status code other than 0, which represents a failure.")
      expect(Fastlane::UI)
        .to receive(:important)
        .with("If you want fastlane to continue anyway, use the `ignore_exit_status` option. 🙈")
      expect(Fastlane::UI).to receive(:important).with("")
      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with("oclint-json-compilation-database finished with errors")

      ActionRunner.oclint_json_compilation_database("ignore_exit_status: false")
    end
  end
end
