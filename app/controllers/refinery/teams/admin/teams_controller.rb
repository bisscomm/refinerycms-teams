module Refinery
  module Teams
    module Admin
      class TeamsController < ::Refinery::AdminController

        crudify :'refinery/teams/team',
                :title_attribute => 'fullname',
                :xhr_paging => true

        private
          def team_params
            params.require(:team).permit(
              :fullname, :title, :body, :photo_id, :email, :draft
            )
          end
      end
    end
  end
end
