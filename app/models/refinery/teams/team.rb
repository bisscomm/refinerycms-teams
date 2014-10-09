module Refinery
  module Teams
    class Team < Refinery::Core::BaseModel
      self.table_name = 'refinery_teams'


      validates :fullname, :presence => true, :uniqueness => true

      belongs_to :photo, :class_name => '::Refinery::Image'

      acts_as_indexed :fields => [:fullname, :title]

    end
  end
end
