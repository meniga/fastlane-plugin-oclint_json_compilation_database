describe Fastlane::Actions::OclintJsonCompilationDatabaseAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The oclint_json_compilation_database plugin is working!")

      Fastlane::Actions::OclintJsonCompilationDatabaseAction.run(nil)
    end
  end
end
