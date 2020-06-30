describe Fastlane::Actions::OclintJsonCompilationDatabaseAction do
  describe 'oclint_json_compilation_database should run with' do
    it 'include params' do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("oclint-json-compilation-database --include ExampleApp")

      ActionRunner.oclint_json_compilation_database("include: ['ExampleApp']")
    end

    it 'exclude params' do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("oclint-json-compilation-database --exclude Pods --exclude build")

      ActionRunner.oclint_json_compilation_database("exclude: ['Pods', 'build']")
    end

    it 'build path' do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("oclint-json-compilation-database -p build")

      ActionRunner.oclint_json_compilation_database("build_path: 'build'")
    end

    it 'report path' do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("oclint-json-compilation-database >> oclint.xml")

      ActionRunner.oclint_json_compilation_database("report_path: 'oclint.xml'")
    end

    it 'enable clang static analyzer' do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("oclint-json-compilation-database -- -enable-clang-static-analyzer")

      ActionRunner.oclint_json_compilation_database("enable_clang_static_analyzer: true")
    end

    it 'all params with proper order' do
      expect(Fastlane::Actions)
        .to receive(:sh)
        .with("oclint-json-compilation-database -p build --include ExampleApp --exclude Pods --exclude build -- -enable-clang-static-analyzer >> oclint.xml")

      ActionRunner.oclint_json_compilation_database(
        "
        enable_clang_static_analyzer: true,
        include: ['ExampleApp'],
        exclude: ['Pods', 'build'],
        build_path: 'build',
        report_path: 'oclint.xml',
        "
      )
    end
  end
end
