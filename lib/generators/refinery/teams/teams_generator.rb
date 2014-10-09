module Refinery
  class TeamsGenerator < Rails::Generators::Base

    source_root File.expand_path("../templates", __FILE__)

    def generate_teams_initializer
      template "config/initializers/refinery/teams.rb.erb", File.join(destination_root, "config", "initializers", "refinery", "teams.rb")
    end

    def rake_db
      rake "refinery_teams:install:migrations"
    end

    def append_load_seed_data
      create_file 'db/seeds.rb' unless File.exists?(File.join(destination_root, 'db', 'seeds.rb'))
      append_file 'db/seeds.rb', :verbose => true do
        <<-EOH

# Added by Refinery CMS Teams extension
Refinery::Teams::Engine.load_seed
        EOH
      end
    end
  end
end
