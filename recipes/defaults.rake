require 'rake'
require 'rake/clean'

desc "Build Shoes"
#task :default => [:ruby18]
task :default => [:shoes]

#desc "Run tests for the interpreter in the sandbox."
#task :check

#desc "Test drive the sandbox (using IRB)."
#task :irb

# Bring DevKit onto PATH before building
task :compiler => ['devkit:activate']

# Only unique cleanups
CLEAN.uniq!
CLOBBER.uniq!
