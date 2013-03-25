begin
  require 'foodcritic'

  FoodCritic::Rake::LintTask.new do |task|
    task.options = { :fail_tags => [ 'any' ] }
  end

  task :default => [ :foodcritic ]
rescue LoadError
end
