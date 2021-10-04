module InterestDays
  module Calculation
    class Base
      attr_reader :start_date, :end_date

      def initialize(start_date:, end_date:)
        @start_date = start_date
        @end_date = end_date
      end

      def day_count_factor
        raise NotImplementedError, "#{self.class} has nit implemented method '#{__method__}"
      end

      private

      def days
        @end_date  - @start_date
      end
    end
  end
end