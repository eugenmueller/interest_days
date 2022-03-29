# frozen_string_literal: true

module InterestDays
  module Calculation
    # Actual/Actual ISDA Convention calculation
    class IsdaActAct < Base

      # The factoris is the sum of (days in leap year / 366) + (days not in leap year / 365)
      def day_count_factor(start_date = @start_date, end_date = @end_date)
        return if start_date > end_date
        if start_date.year == end_date.year
          # if we are in the same year then return days in this year / (365 or 366)
          calculate_factor(start_date, end_date)
        else
          start_of_next_year = Date.new(year: start_date.year + 1, month: 1, day: 1)
          calculate_factor(start_date, start_of_next_year) + day_count_factor(start_of_next_year, end_date)
        end
      end

      private

      def calculate_factor(start_date, end_date)
        days_in_year = start_date.leap? ? 366 : 365
        Rational(end_date - start_date, days_in_year)
      end
    end
  end
end
