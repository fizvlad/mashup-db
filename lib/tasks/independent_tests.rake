namespace 'test' do
  task :lib => :environment do
    test_files = FileList['test/lib/**/*_test.rb']
    Rails::TestUnit::Runner.run(test_files)
  end
end
