require 'acts_as_indexed'

module Refinery
  module Teams
    class Category < Refinery::Core::BaseModel
      self.table_name = 'refinery_teams_categories'

      translates :title, :slug
      extend FriendlyId

      validates :title, :presence => true, :uniqueness => true

      acts_as_indexed :fields => [:title]
      acts_as_nested_set :dependent => :destroy

      friendly_id :friendly_id_source, use: :globalize

      has_many :categorizations, :dependent => :destroy, :foreign_key => :teams_category_id
      has_many :teams, :through => :categorizations, :source => :team

      # If title changes tell friendly_id to regenerate slug when
      # saving record
      def should_generate_new_friendly_id?
        title_changed?
      end

      def friendly_id_source
        title
      end

      def translated_to_default_locale?
        persisted? && translations.any?{ |t| t.locale == Refinery::I18n.default_frontend_locale}
      end
    end
  end
end