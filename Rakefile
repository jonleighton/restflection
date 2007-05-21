require 'rubygems'
require 'rake'

desc 'Default: run specs'
task :default => :spec

require 'spec/rake/spectask'

desc "Run specs"
Spec::Rake::SpecTask.new do |t|
  t.spec_opts = %w(-f specdoc)
end

desc "Run specs with Heckle"
Spec::Rake::SpecTask.new(:heckle) do |t|
  t.spec_opts = %w(-H Restflection)
end

desc "Generate code coverage"
Spec::Rake::SpecTask.new(:coverage) do |t|
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end
