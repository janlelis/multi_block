# -*- encoding: utf-8 -*-

require File.expand_path('../lib/multi_block/version', __FILE__)
 
Gem::Specification.new do |s|
  s.name        = "multi_block"
  s.version     = MultiBlock::VERSION
  s.authors     = ["Jan Lelis"]
  s.email       = "mail@janlelis.de"
  s.homepage    = "https://github.com/janlelis/multi_block"
  s.summary     = 'MultiBlock is a mini framework for passing multiple blocks to methods.'
  s.description = 'MultiBlock is a mini framework for passing multiple blocks to methods. It uses "named procs" to accomplish this in a nice way. The receiving method can either yield all blocks, or just call specific ones, identified by order or name. '
  s.required_ruby_version = '>= 1.9.3'
  s.files = Dir.glob %w{multi_block.gemspec lib/multi_block.rb lib/multi_block/version.rb lib/multi_block/implementation.rb lib/multi_block/core_ext.rb lib/multi_block/array.rb spec/multi_block_spec.rb}
  s.extra_rdoc_files = ["README.rdoc", "MIT-LICENSE.txt", "CHANGELOG.rdoc", ".travis.yml"]
  s.license = 'MIT'
  s.add_dependency 'named_proc', '~> 1.1'
  s.add_development_dependency 'rspec', '~> 3.2'
  s.add_development_dependency 'rake', '~> 10.4'
end
