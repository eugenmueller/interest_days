# frozen_string_literal: true

module InterestDays
  module Calculation
    # ISDA 30 E 360 Convention calculation
    class ThirtyThreesixtyBase < Base
      RELEVANT_DAYS_IN_YEAR = 360
      RELEVANT_DAY_IN_MONTH = 30

      def day_count_factor
        (year_interval_in_days + month_interval_in_days + day_interval).fdiv(RELEVANT_DAYS_IN_YEAR)
      end

      private

      def year_interval_in_days
        RELEVANT_DAYS_IN_YEAR * (@end_date.year - @start_date.year)
      end

      def month_interval_in_days
        RELEVANT_DAY_IN_MONTH * (@end_date.month - @start_date.month)
      end

      def day_interval
        end_date_days - start_date_days
        # [@end_date.day, 30].min - [@start_date.day, 30].min
      end

      def end_date_days
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}"
      end

      def start_date_days
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}"
      end

      def days_in_month_for(date)
        Date.new(date.year, date.month, -1).day
      end
    end
  end
end
