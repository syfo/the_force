require 'rubygems'
require 'rake'
require 'rake/testtask'

include_file_globs = ['README.rdoc', 'LICENSE', 'Rakefile', 'init.rb', '{lib}/**/*']
exclude_file_globs = []

spec = Gem::Specification.new do |s| 
  s.name              = "the_force"
  s.version           = '0.3.0'
  s.author            = "Ryan Ziegler"
  s.email             = "info@symbolforce.com"
  s.homepage          = "http://www.symbolforce.com"
  s.platform          = Gem::Platform::RUBY
  s.summary           = "Common code for Symbolforce"
  s.description       = "Common code for Symbolforce"
  s.files             = FileList[include_file_globs].to_a - FileList[exclude_file_globs].to_a
  s.require_path      = "lib"
  s.test_files        = FileList["test/**/test_*.rb"].to_a
#  s.has_rdoc          = true
  s.extra_rdoc_files  = FileList["README*"].to_a
  s.rdoc_options << '--line-numbers' << '--inline-source'
end

desc "Generate gemspec for gemcutter"
task :gemspec => :clean do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end

desc 'Clean up files.'
task :clean do
  FileUtils.rm "*.gemspec" rescue nil
  FileUtils.rm "the_force-0.0.1.gem" rescue nil
end

desc 'Default, do nothing'
task :default => :test do 
end

Rake::TestTask.new do |t|
  t.libs << "lib/the_force/"
  t.test_files = FileList['test/**/*.rb']
  t.ruby_opts = ["-r rubygems"]
  t.verbose = true
  t.warning = true
end