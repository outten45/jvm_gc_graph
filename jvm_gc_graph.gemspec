# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "jvm_gc_graph/version"

Gem::Specification.new do |s|
  s.name        = "jvm_gc_graph"
  s.version     = JvmGcGraph::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Richard Outten"]
  s.email       = ["outtenr@gmail.com"]
  s.homepage    = "https://github.com/outten45/jvm_gc_graph"
  s.summary     = %q{Creates an HTML output for graphing Java GC.}
  s.description = %q{Creates an HTML output that uses Google Interactive Charts
to display the GC in graph format.}

  s.rubyforge_project = "jvm_gc_graph"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = %w(jvm_gc_graph)
    #`git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
