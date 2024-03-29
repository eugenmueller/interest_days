# frozen_string_literal: true

module InterestDays
  module Calculation
    # ISDA Act Act Convention calculation
    class IcmaActAct < Base
      DAYS_IN_YEAR = 365
      DAYS_IN_LEAP_YEAR = 366

      def day_count_factor
        return multiple_years_day_count_factor if years_in_between_factor.positive?

        days.fdiv(year_days_in_period)
      end

      private

      # calculate for periods smaller than a year
      def year_days_in_period
        period_contains_leap_day? ? DAYS_IN_LEAP_YEAR : DAYS_IN_YEAR
      end

      def period_contains_leap_day?
        !leap_day.nil? && leap_day.between?(start_date, end_date)
      end

      def leap_day
        @leap_day ||= if start_date.leap?
                        Date.new(start_date.year, 2, 29)
                      elsif end_date.leap?
                        Date.new(end_date.year, 2, 29)
                      end
      end

      # claculate for period span more than a year
      def multiple_years_day_count_factor
        start_date_period_factor + years_in_between_factor + end_date_period_factor
      end

      def start_date_period_factor
        (start_date_days_in_year - start_date.yday).fdiv(start_date_days_in_year)
      end

      def end_date_period_factor
        end_date.yday.fdiv(end_date_days_in_year)
      end

      def years_in_between_factor
        (end_date.year - start_date.year) - 1
      end

      def start_date_period_with_leap_date?
        start_date.leap? && Date.new(start_date.year, 2, 29)&.between?(start_date, Date.new(start_date.year, 12, 31))
      end

      def end_date_period_with_leap_date?
        end_date.leap? && Date.new(end_date.year, 2, 29)&.between?(Date.new(end_date.year, 1, 1), end_date)
      end

      def start_date_and_end_date_in_same_year?
        start_date.year.eql?(end_date.year)
      end

      def start_date_days_in_year
        start_date_period_with_leap_date? ? DAYS_IN_LEAP_YEAR : DAYS_IN_YEAR
      end

      def end_date_days_in_year
        end_date_period_with_leap_date? ? DAYS_IN_LEAP_YEAR : DAYS_IN_YEAR
      end
    end
  end
end
