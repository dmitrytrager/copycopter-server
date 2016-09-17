set :user, "deploy"
set :port, 22
set :deploy_via, :remote_cache
set :use_sudo, false

server "78.47.50.178",
  roles: [:web, :app, :db],
  port: fetch(:port),
  user: fetch(:user),
  primary: true

set :deploy_to, "/home/#{fetch(:user)}/apps/#{fetch(:application)}"

# ssh_options[:forward_agent] = true
set :ssh_options, {
  forward_agent: true,
  auth_methods: %w(publickey),
  user: "deploy",
}

set :rails_env, "production"
set :conditionally_migrate, true
set :pry, true
