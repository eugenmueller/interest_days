# frozen_string_literal: true

module InterestDays
  module Calculation
    # ISDA 30 E 360 Convention calculation
    class Isda30e360 < Base
      RELEVANT_DAYS_IN_YEAR = 360

      def day_count_factor
        (year_interval_in_days + month_interval_in_days + day_interval).fdiv(RELEVANT_DAYS_IN_YEAR)
      end

      private

      def year_interval_in_days
        360 * (@end_date.year - @start_date.year)
      end

      def month_interval_in_days
        30 * (@end_date.month - @start_date.month)
      end

      def day_interval
        [@end_date.day, 30].min - [@start_date.day, 30].min
      end
    end
  end
end
