namespace 'yardoc' do
  desc 'Generate documentation'
  task :generate => :environment do
    puts `yardoc lib/*`
  end

  desc 'List undocumented elements'
  task :undoc => :environment do
    puts `yardoc stats --list-undoc lib/*`
  end
end
