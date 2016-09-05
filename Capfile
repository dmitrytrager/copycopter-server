# load "deploy"
# # Uncomment if you are using Rails' asset pipeline
# load "deploy/assets"
# Dir[
#   "vendor/gems/*/recipes/*.rb",
#   "vendor/plugins/*/recipes/*.rb"
# ].each { |plugin| load(plugin) }
# load "config/deploy" # remove this line to skip loading any of the default tasks

require "capistrano/setup"
require "capistrano/deploy"
require "capistrano/rvm"
require "capistrano/bundler"
require "capistrano/rails/assets"
require "capistrano/rails/migrations"
require "capistrano3/unicorn"

# Load custom tasks from `lib/capistrano/tasks' if you have any defined
Dir.glob("lib/capistrano/tasks/*.rake").each { |r| import r }
