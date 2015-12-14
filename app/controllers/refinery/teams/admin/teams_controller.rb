module Refinery
  module Teams
    module Admin
      class TeamsController < ::Refinery::AdminController

        crudify :'refinery/teams/team',
                order: 'position ASC',
                include: [:translations],
                paging: false

        helper :'refinery/teams/admin'

        before_action :find_all_categories,
                      only: [:new, :edit, :create, :update]

        before_action :check_category_ids, only: :update

        def uncategorized
          @teams = Refinery::Teams::Team.uncategorized.page(params[:page])

        end

        protected

        def find_all_categories
          @categories = Refinery::Teams::Category.all
        end

        def check_category_ids
          team_params[:category_ids] ||= []
        end

        def team_params
          params.require(:team).permit(permitted_team_params)
        end

        private

        def permitted_team_params
          [
            :fullname, :job_title, :body, :photo_id, :email, :draft,
            category_ids: []
          ]
        end
      end
    end
  end
end
