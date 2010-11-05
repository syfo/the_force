Capistrano::Configuration.instance(:sf_defaults).load do
  set :repository do; "git@git.symbolforce.com:#{application}"; end
  set :deploy_to do; "/var/www/#{application}"; end

  set :rails_env, "production"
  set :scm, :git
  set :branch, "master"
  set :server_name, "mastodon.symbolforce.com"
  set :deploy_via, :remote_cache
  set :copy_strategy, :export
  set :user, 'root'
  set :runner, 'root'
  #set :deploy_via, :copy
  #shallow clone and non-master branch dont work together, but only git clone --depth 1
  #set :git_shallow_clone, 1
  #remote local repo on deployment machine, and deploy from there. fastest

  set :use_sudo, false
  default_run_options[:pty] = true
end

