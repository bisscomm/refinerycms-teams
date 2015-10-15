module Refinery
  module Teams
    module Admin
      class CategoriesController < ::Refinery::AdminController

        crudify :'refinery/teams/category',
                :order => "lft ASC",
                :include => [:children, :translations]

        helper :'refinery/teams/admin'

        def new
          @category = ::Refinery::Teams::Category.new(:parent_id => find_parent_category)
        end

        def children
          @category = find_category
          render :layout => false
        end

        private
        
        def category_params
          params.require(:category).permit(
            :title,
            :parent_id
          )
        end

        protected
        
        def find_parent_category
          if params[:parent_id].present?
            ::Refinery::Teams::Category.find(params[:parent_id])
          end
        end

        def find_category
          if params[:id].present?
            @category = ::Refinery::Teams::Category.friendly.find(params[:id])
          end
        end

        def after_update_positions
          find_all_categories
          render :partial => '/refinery/teams/admin/categories/sortable_list' and return
        end
      end
    end
  end
end