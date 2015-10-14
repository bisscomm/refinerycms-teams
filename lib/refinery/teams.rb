require 'acts_as_indexed'
require 'refinerycms-core'
require 'friendly_id/globalize'

module Refinery
  autoload :TeamsGenerator, 'generators/refinery/teams/teams_generator'

  module Teams
    require 'refinery/teams/engine'
    require 'refinery/teams/configuration'

    class << self
      attr_writer :root

      def root
        @root ||= Pathname.new(File.expand_path('../../../', __FILE__))
      end

      def factory_paths
        @factory_paths ||= [ root.join('spec', 'factories').to_s ]
      end
    end
  end
end
