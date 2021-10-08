# frozen_string_literal: true

module InterestDays
  module Calculation
    # Base calculation class
    class Base
      attr_reader :start_date, :end_date

      def initialize(start_date:, end_date:)
        @start_date = start_date
        @end_date = end_date
      end

      def day_count_factor
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}"
      end

      private

      def days
        @end_date - @start_date
      end
    end
  end
end
