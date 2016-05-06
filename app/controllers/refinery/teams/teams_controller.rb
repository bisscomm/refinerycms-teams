module Refinery
  module Teams
    class TeamsController < ::ApplicationController

      before_action :find_all_teams, only: [ :index, :show ]
      before_action :find_all_team_categories, only: [ :index ]
      before_action :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @team in the line below:
        present(@page)
      end

      def show
        @team = Team.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @team in the line below:
        present(@page)
      end

      protected

      def find_all_teams
        @teams = Team.published
      end

      def find_all_team_categories
        @team_categories = Refinery::Teams::Category.all
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => Refinery::Teams.page_url).first
      end

    end
  end
end
