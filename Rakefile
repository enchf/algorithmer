# frozen_string_literal: true

require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

require "rubocop/rake_task"

RuboCop::RakeTask.new

Rake::TestTask.new(:integration) do |t|
  t.libs << "lib"
  t.test_files = ['integration/commands_test.rb']
end

task default: %i[test rubocop integration]
