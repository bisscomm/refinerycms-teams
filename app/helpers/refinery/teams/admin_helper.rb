module Refinery
  module Teams
    module AdminHelper
      def title_with_translations(record)
        record.title.presence || record.translations.detect { |t| t.title.present?}.title
      end
    end
  end
end