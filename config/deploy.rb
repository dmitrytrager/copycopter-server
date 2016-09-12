set :application, "copycopter-server"
set :port, 22
set :user, "deploy"
set :rails_env, "production"
set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :bundle_binstubs, nil

server "78.47.50.178",
  roles: [:web, :app, :db],
  port: fetch(:port),
  user: fetch(:user),
  primary: true

set :scm, :git
# set :repository, "git@github.com:dmitrytrager/#{fetch(:application)}.git"
set :repo_url, "git@github.com:dmitrytrager/#{fetch(:application)}.git"
# set :branch, :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :conditionally_migrate, true
set :pry, true

# ssh_options[:forward_agent] = true
set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey),
  user: "deploy",
}

set :linked_files, fetch(:linked_files, []).push("config/database.yml")
set :linked_dirs,
  fetch(:linked_dirs, []).push(
    "log",
    "tmp/pids",
    "tmp/cache",
    "tmp/sockets",
    "vendor/bundle",
    "public/system"
  )

after "deploy", "deploy:cleanup"
after "deploy:publishing", "deploy:restart"

namespace :deploy do
  task :start do
  end

  task :stop do
  end

  task :restart do
    on roles(:app), except: { no_release: true } do
      invoke "unicorn:reload"
    end
  end

  desc "Make sure local git is in sync with remote"
  task "check_revision" do
    on roles(:web) do
      unless `git rev-parse HEAD` == `git rev-parse origin/master`
        puts "WARNING: HEAD is not the same as origin/master"
        puts "Run `git push` to sync changes."
        exit
      end
    end
  end
  before "deploy", "deploy:check_revision"
end
