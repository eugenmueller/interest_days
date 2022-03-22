# frozen_string_literal: true

module InterestDays
  module Calculation
    # ISDA Act Act Convention calculation
    class IsdaActAct < Base
      RELEVANT_DAYS_IN_YEAR = 365
      RELEVANT_DAYS_IN_LEAP_YEAR = 366

      def day_count_factor
        return days.fdiv(stard_date_days_in_year) if start_date_and_end_date_in_same_year?

        end_date_days.fdiv(end_date_days_in_year) +
          start_date_days.fdiv(stard_date_days_in_year) +
          full_years_between_start_and_end_date
      end

      private

      def full_years_between_start_and_end_date
        (end_date.year - start_date.year) - 1
      end

      def start_date_and_end_date_in_same_year?
        start_date.year.eql?(end_date.year)
      end

      def stard_date_days_in_year
        start_date.leap? ? RELEVANT_DAYS_IN_LEAP_YEAR : RELEVANT_DAYS_IN_YEAR
      end

      def end_date_days_in_year
        end_date.leap? ? RELEVANT_DAYS_IN_LEAP_YEAR : RELEVANT_DAYS_IN_YEAR
      end

      def start_date_days
        stard_date_days_in_year - start_date.yday
      end

      def end_date_days
        end_date.yday
      end
    end
  end
end
