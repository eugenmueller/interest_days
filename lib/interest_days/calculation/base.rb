# frozen_string_literal: true

module InterestDays
  module Calculation
    # StartDateBeforeEndDateError class
    class StartDateBeforeEndDateError < StandardError
      def initialize(msg = "End date have to be after start date!")
        super(msg)
      end
    end

    # Base calculation class
    class Base
      attr_reader :start_date, :end_date

      def initialize(start_date:, end_date:)
        @start_date = start_date
        @end_date = end_date

        raise StartDateBeforeEndDateError if start_date_after_end_date?
      end

      def day_count_factor
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}"
      end

      private

      def start_date_after_end_date?
        start_date > end_date
      end

      def days
        @end_date - @start_date
      end
    end
  end
end
