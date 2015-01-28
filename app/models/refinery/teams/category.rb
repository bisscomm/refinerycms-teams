module Refinery
  module Teams
    class Category < Refinery::Core::BaseModel
      self.table_name = 'refinery_teams_categories'

      translates :title

      validates :title, :presence => true, :uniqueness => true

      has_many :categorizations, :dependent => :destroy, :foreign_key => :teams_category_id
      has_many :teams, :through => :categorizations, :source => :team

      acts_as_indexed :fields => [:title]

      def translated_to_default_locale?
        persisted? && translations.any?{ |t| t.locale == Refinery::I18n.default_frontend_locale}
      end
    end
  end
end