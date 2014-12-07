namespace :analyze_code do
  unless Rails.env == 'production'
    require 'rspec/core/rake_task'
    require 'rubocop/rake_task'
    require 'reek/rake/task'

    desc 'Execute Rspec'
    RSpec::Core::RakeTask.new(:spec) do |tsk|
      tsk.rspec_opts = '--format p'
    end

    desc 'Execute rubocop -DR'
    RuboCop::RakeTask.new(:rubocop) do |tsk|
      tsk.options = ['-DR'] # Rails, display cop name
      tsk.fail_on_error = false
    end

    desc 'Execute reek'
    Reek::Rake::Task.new do |tsk|
      tsk.source_files = ['app/**/*.rb', 'lib/**/*.rb', 'lib/tasks/*.rake', 'config/**/*.rb']
      tsk.fail_on_error = false
      # tsk.verbose = true
    end

    desc 'Execute rails_best_practices'
    task ruby_best_practices: :environment do
      require 'rails_best_practices'
      analyzer = RailsBestPractices::Analyzer.new('.')
      analyzer.analyze
      puts analyzer.output
    end

  end
end

task :analyze_code do
  %w(rubocop reek ruby_best_practices spec).each { |task| Rake::Task["analyze_code:#{task}"].invoke }
end
