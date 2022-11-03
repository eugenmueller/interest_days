# frozen_string_literal: true

module InterestDays
  # Main calculator class
  class Calculator
    attr_accessor :strategy, :start_date, :end_date

    def initialize(start_date:, end_date:, strategy:)
      @start_date = start_date
      @end_date = end_date
      @strategy = strategies[strategy.to_sym]
    end

    def interest_day_count_factor
      raise StandardError, "Strategy is not set" if @strategy.nil?

      @strategy.new(start_date: @start_date, end_date: @end_date).day_count_factor
    end

    private

    def strategies
      @strategies ||= {
        isda_act_360: InterestDays::Calculation::IsdaAct360,
        isda_act_364: InterestDays::Calculation::IsdaAct364,
        isda_act_365: InterestDays::Calculation::IsdaAct365,
        isda_act_act: InterestDays::Calculation::IsdaActAct,
        isda_30_e_360: InterestDays::Calculation::Isda30e360,
        bond_basis_30_360: InterestDays::Calculation::Isda30e360,
        us_eom_30_360: InterestDays::Calculation::UsEom30360,
        icma_act_act: InterestDays::Calculation::IcmaActAct
      }
    end
  end
end
