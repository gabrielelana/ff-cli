require 'rake/clean'
require 'rubygems'
require 'rubygems/package_task'
require 'rdoc/task'
require 'cucumber'
require 'cucumber/rake/task'
Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc","lib/**/*.rb","bin/**/*")
  rd.title = 'Your application title'
end

spec = eval(File.read('ff.gemspec'))

Gem::PackageTask.new(spec) do |pkg|
end
CUKE_RESULTS = 'results.html'
CLEAN << CUKE_RESULTS
desc 'Run features'
Cucumber::Rake::Task.new(:features) do |t|
  opts = "features --format html -o #{CUKE_RESULTS} --format progress -x"
  opts += " --tags #{ENV['TAGS']}" if ENV['TAGS']
  t.cucumber_opts =  opts
  t.fork = false
end

desc 'Run features tagged as work-in-progress (@wip)'
Cucumber::Rake::Task.new('features:wip') do |t|
  tag_opts = ' --tags ~@pending'
  tag_opts = ' --tags @wip'
  t.cucumber_opts = "features --format html -o #{CUKE_RESULTS} --format pretty -x -s#{tag_opts}"
  t.fork = false
end

require 'rspec/core/rake_task'
desc 'Run RSpec tests'
RSpec::Core::RakeTask.new('spec')

task :default => [:spec,:features]

task :cucumber => :features
task 'cucumber:wip' => 'features:wip'
task :wip => 'features:wip'

