module Refinery
  module Teams
    class Categorization < ActiveRecord::Base
      self.table_name = 'refinery_teams_categories_teams'

      belongs_to :team,           :class_name => 'Refinery::Teams::Team',  :foreign_key => :team_id
      belongs_to :teams_category, :class_name => 'Refinery::Teams::Category', :foreign_key => :teams_category_id
    end
  end
end