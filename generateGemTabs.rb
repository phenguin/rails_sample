require 'rubygems'
require 'bundler'

paths = Bundler.load.specs.map(&:full_gem_path)

system("ctags -R -f gems.tags #{paths.join(' ')}")

