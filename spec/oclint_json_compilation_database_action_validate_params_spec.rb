describe Fastlane::Actions::OclintJsonCompilationDatabaseAction do
  describe 'oclint_json_compilation_database' do
    it 'should succed executable validation when file exist' do
      expect(Fastlane::UI).not_to(receive(:user_error!))
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("../spec/fake_oclint_json_compilation_database")

      ActionRunner.oclint_json_compilation_database("executable: '../spec/fake_oclint_json_compilation_database'")
    end

    it 'should fail executable validation when file exist' do
      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with(match("Couldn't find executable path"))

      ActionRunner.oclint_json_compilation_database("executable: '../oclint/fake-oclint-json-compilation-database'")
    end

    it 'should succed report type validation when html' do
      expect(Fastlane::UI).not_to(receive(:user_error!))
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("oclint-json-compilation-database -- -report-type html")

      ActionRunner.oclint_json_compilation_database("report_type: 'html'")
    end

    it 'should fail report type validation validation when unexpected' do
      expect(Fastlane::UI)
        .to receive(:user_error!)
        .with("Available values are 'text', 'html', 'xml', 'json', 'pmd', 'xcode'")

      ActionRunner.oclint_json_compilation_database("report_type: 'the spanish inquisition'")
    end
  end
end
