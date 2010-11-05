#CRZ - sep 24 10 installs app to mastodon as www user
#    - beware, www user needs to have custom PATH in .ssh/environment for things to work right
#    - uses custom tasks for bundler support
#
#    - oct 28 10 - copied from invoicing app deploy.rb
#    - to deploy on a new box, first cap deploy:setup, then add database.yml on the server in shared, then deploy:cold
#
#    - nov 4 - putting capistrano recipe into the_force, use like this
#         require 'the_force/lib/the_force/capistrano/internal/defaults'
#         set :application, "amie"
#         set :shared_dirs, %w(public/system log db/sqlite)
#         set :shared_files, %w(config/database.yml config/cdn.yml)
#         require 'the_force/lib/the_force/capistrano/internal/rails'

require 'highline'

Capistrano::Configuration.instance(:sf_internal_rails).load do
  [:server_name, :application, :shared_dirs, :shared_files].each do |v|
    raise "#{v} must be set to use this capistrano recipe." unless exists? v
  end

  role :app, "#{server_name}"
  role :db, "#{server_name}", :primary => true

  namespace :sf do
    desc "symlink shared directories"
    task :symlink_shared_dirs, :roles => :app do
      for d in shared_dirs
        run <<-EOF
        mkdir -p #{shared_path}/#{d} &&
        rm -rf  #{release_path}/#{d}; true;
        ln -s #{shared_path}/#{d} #{release_path}/#{d}
        EOF
      end
    end

    desc "symlinks shared files"
    task :symlink_shared_files, :roles => :app do
      for f in shared_files
        run "mkdir -p #{deploy_to}/shared/#{File.dirname(f)}"
        run "rm #{release_path}/#{f}; true"
        run "ln -s #{shared_path}/#{f} #{release_path}/#{f}"
      end
    end
  
    desc "set permissions on mastodon"
    task :chowning, :roles => :app do
      run "chown -R apache.apache #{release_path}"
    end
  end

  namespace :deploy do
    desc "restart passenger ruby process"
    task :restart, :roles => :app do
      run "touch #{current_path}/tmp/restart.txt"
      on_rollback do 
        run "touch #{current_path}/tmp/restart.txt"
      end
    end
  end

  namespace :bundler do
    task :create_symlink, :roles => :app do
      shared_dir = File.join(shared_path, 'bundle')
      release_dir = File.join(current_release, '.bundle')
      run "mkdir -p #{shared_dir} && ln -s #{shared_dir} #{release_dir}"
    end

    task :bundle_new_release, :roles => :app do
      bundler.create_symlink
      run "cd #{release_path} && bundle install --deployment --without test development"
    end
  end

  after 'deploy:update_code', 'bundler:bundle_new_release'
  after 'deploy:finalize_update', 'sf:chowning'
  after 'sf:chowning', 'sf:symlink_shared_files'
  after 'sf:symlink_shared_files', 'sf:symlink_shared_dirs'
  after 'deploy:symlink', 'deploy:migrate'
end
