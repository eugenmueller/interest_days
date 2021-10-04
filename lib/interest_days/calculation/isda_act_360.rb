# frozen_string_literal: true

module InterestDays
  module Calculation
    # ISDA Act 360 Convention calculation
    class IsdaAct360 < Base
      RELEVANT_DAYS_IN_YEAR = 360

      def day_count_factor
        days.fdiv(RELEVANT_DAYS_IN_YEAR)
      end
    end
  end
end
