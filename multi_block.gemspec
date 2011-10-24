# -*- encoding: utf-8 -*-
require 'rubygems' unless defined? Gem
 
Gem::Specification.new do |s|
  s.name        = "multi_block"
  s.version     = 1.0
  s.authors     = ["Jan Lelis"]
  s.email       = "mail@janlelis.de"
  s.homepage    = "https://gist.github.com/4b2f5fd0b45118e46d0f"
  s.summary     = 'MultiBlock is a mini framework for passing multiple blocks to methods.'
  s.description = 'MultiBlock is a mini framework for passing multiple blocks to methods. It uses "named procs" to accomplish this in a nice way. The receiving method can either yield all blocks, or just call specific ones, identified by order or name. '
  s.required_ruby_version     = '>= 1.9.2'
  s.files = Dir.glob %w{multi_block.gemspec lib/multi_block.rb spec/multi_block_spec.rb}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE.txt"]
  s.license = 'MIT'
  s.add_dependency 'named_proc'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-core'
end
