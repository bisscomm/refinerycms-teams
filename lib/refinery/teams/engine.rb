module Refinery
  module Teams
    class Engine < Rails::Engine
      extend Refinery::Engine
      isolate_namespace Refinery::Teams

      engine_name :refinery_teams

      before_inclusion do
        Refinery::Plugin.register do |plugin|
          plugin.name = "refinery_teams"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.teams_admin_teams_path }
          plugin.menu_match = %r{refinery/(teams)(/.+?)?$}
          plugin.pathname = root
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Teams)
      end
    end
  end
end
