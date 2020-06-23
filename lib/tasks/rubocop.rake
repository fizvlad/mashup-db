require 'rubocop/rake_task'
RuboCop::RakeTask.new(:rubocop) {}

namespace 'rubocop' do
  desc 'Generate rubocop TODO file.'
  task :todo => :environment do
    puts `rubocop --auto-gen-config`
  end
end
