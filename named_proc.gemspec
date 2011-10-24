# -*- encoding: utf-8 -*-
require 'rubygems' unless defined? Gem
 
Gem::Specification.new do |s|
  s.name        = "named_proc"
  s.version     = 1.0
  s.authors     = ["Jan Lelis"]
  s.email       = "mail@janlelis.de"
  s.homepage    = "https://gist.github.com/4b2f5fd0b45118e46d0f"
  s.summary     = "NamedProc: Like anonymous procs, but have a name."
  s.description = "NamedProc: Like anonymous procs, but have a name. Example: lambda.codebrawl {} # creates an empty lambda with the name :codebrawl"
  s.required_ruby_version     = '>= 1.9.2'
  s.files = Dir.glob %w{named_proc.gemspec lib/named_proc.rb spec/named_proc_spec.rb}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE.txt"]
  s.license = 'MIT'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rspec-core'
end
