# frozen_string_literal: true

module InterestDays
  module Calculation
    # ISDA 30 E 360 Convention calculation
    class Isda30e360 < ThirtyThreesixtyBase
      private

      def end_date_days
        [@end_date.day, RELEVANT_DAY_IN_MONTH].min
      end

      def start_date_days
        [@start_date.day, RELEVANT_DAY_IN_MONTH].min
      end
    end
  end
end
