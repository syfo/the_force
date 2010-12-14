# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{the_force}
  s.version = "0.3.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Ziegler"]
  s.date = %q{2010-12-13}
  s.description = %q{Common code for Symbolforce}
  s.email = %q{info@symbolforce.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["README.rdoc", "LICENSE", "Rakefile", "init.rb", "lib/the_force", "lib/the_force/capistrano", "lib/the_force/capistrano/internal", "lib/the_force/capistrano/internal/defaults.rb", "lib/the_force/capistrano/internal/rails.rb", "lib/the_force/keep_trying.rb", "lib/the_force/memoize.rb", "lib/the_force/object_support.rb", "lib/the_force/rails_support.rb", "lib/the_force/remote_includes.rb", "lib/the_force/ruby_version.rb", "lib/the_force/thread_pool.rb", "lib/the_force/timer.rb", "lib/the_force.rb", "test/test_helper.rb", "test/unit/test_keep_trying.rb", "test/unit/test_memoize.rb", "test/unit/test_object_support.rb", "test/unit/test_rails_support.rb", "test/unit/test_ruby_version.rb"]
  s.homepage = %q{http://www.symbolforce.com}
  s.rdoc_options = ["--line-numbers", "--inline-source"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Common code for Symbolforce}
  s.test_files = ["test/test_helper.rb", "test/unit/test_keep_trying.rb", "test/unit/test_memoize.rb", "test/unit/test_object_support.rb", "test/unit/test_rails_support.rb", "test/unit/test_ruby_version.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
