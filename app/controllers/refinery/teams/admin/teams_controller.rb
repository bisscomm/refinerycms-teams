module Refinery
  module Teams
    module Admin
      class TeamsController < ::Refinery::AdminController

        crudify :'refinery/teams/team',
                :title_attribute => 'fullname',
                :xhr_paging => true

      end
    end
  end
end
