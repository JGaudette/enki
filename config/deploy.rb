set :repository,  "jon@horder.digital-drip.com:/home/jon/git/ddrip.git"
set :application, "ddrip"

set :scm, :git
set :user, 'jon'
set :branch, 'ddrip'

task :production do
  puts 'PRODUCTION DEPLOY'
  set :deploy_to, "/srv/#{application}"

  role :web, "digital-drip.com"                          # Your HTTP server, Apache/etc
  role :app, "digital-drip.com"                          # This may be the same as your `Web` server
  role :db,  "digital-drip.com", :primary => true # This is where Rails migrations will run
end

task :staging do
  puts 'STAGING DEPLOY'
  set :deploy_to, "/srv/rails/#{application}"

  role :web, "staging.digital-drip.com"                          # Your HTTP server, Apache/etc
  role :app, "staging.digital-drip.com"                          # This may be the same as your `Web` server
  role :db,  "staging.digital-drip.com", :primary => true # This is where Rails migrations will run
end



# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
