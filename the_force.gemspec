# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{the_force}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Ziegler"]
  s.date = %q{2010-10-03}
  s.description = %q{Common code for Symbolforce}
  s.email = %q{info@symbolforce.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "LICENSE", "Rakefile", "init.rb", "lib/the_force", "lib/the_force/keep_trying.rb", "lib/the_force/memoize.rb", "lib/the_force/object_support.rb", "lib/the_force/remote_includes.rb", "lib/the_force/thread_pool.rb", "lib/the_force/timer.rb", "lib/the_force.rb", "test/test_helper.rb", "test/unit/test_keep_trying.rb", "test/unit/test_memoize.rb", "test/unit/test_object_support.rb"]
  s.homepage = %q{http://www.symbolforce.com}
  s.rdoc_options = ["--line-numbers", "--inline-source"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Common code for Symbolforce}
  s.test_files = ["test/test_helper.rb", "test/unit/test_keep_trying.rb", "test/unit/test_memoize.rb", "test/unit/test_object_support.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
