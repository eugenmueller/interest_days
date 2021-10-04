# frozen_string_literal: true

module InterestDays
  module Calculation
    # ISDA 30 E 365 Convention calculation
    class IsdaAct365 < Base
      RELEVANT_DAYS_IN_YEAR = 365

      def day_count_factor
        days.fdiv(RELEVANT_DAYS_IN_YEAR)
      end
    end
  end
end
