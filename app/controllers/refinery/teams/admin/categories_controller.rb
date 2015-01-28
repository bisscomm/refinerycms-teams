module Refinery
  module Teams
    module Admin
      class CategoriesController < ::Refinery::AdminController

        crudify :'refinery/teams/category',
                :order => "position ASC",
                :include => [:translations],
                :xhr_paging => true

        helper :'refinery/teams/admin'

        private
          def category_params
            params.require(:category).permit(
              :title
            )
          end

        protected
          def after_update_positions
            find_all_categories
            render :partial => '/refinery/teams/admin/categories/sortable_list' and return
          end

      end
    end
  end
end