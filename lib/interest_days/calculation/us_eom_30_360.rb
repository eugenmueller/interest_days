# frozen_string_literal: true

module InterestDays
  module Calculation
    # ISDA 30 E 360 Convention calculation
    class UsEom30360 < ThirtyThreesixtyBase
      private

      # D2 day
      def end_date_days
        if ((@start_date.month == 2 && @start_date.date == days_in_month_for(@start_date)) &&
           (@end_date.month == 2 && @end_date.date == days_in_month_for(@end_date))) ||
           (@end_date.day == 31 && @start_date.day >= 30)
          RELEVANT_DAY_IN_MONTH
        else
          @end_date.day
        end
      end

      # D1 day
      def start_date_days
        if (@start_date.month == 2 && @start_date.date == days_in_month_for(@start_date)) || @start_date.day == 31
          RELEVANT_DAY_IN_MONTH
        else
          @start_date.day
        end
      end
    end
  end
end
