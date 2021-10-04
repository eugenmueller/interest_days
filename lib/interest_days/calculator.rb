module InterestDays
  class Calculator
    attr_accessor :strategy, :start_date, :end_date

    def initialize(start_date:, end_date:, strategy:)
      @start_date = start_date
      @end_date = end_date
      @strategy = strategies[strategy.to_sym]
    end

    def interest_day_count_factor
      raise StandardError, 'Strategy is not set' if @strategy.nil?
      
      @strategy.new(start_date: @start_date, end_date: @end_date).day_count_factor
    end

    private

    def strategies
      @strategies ||= {
        isda_act_360: InterestDays::Calculation::IsdaAct360,
        isda_act_365: InterestDays::Calculation::IsdaAct365,
        isda_30_e_360: InterestDays::Calculation::Isda30e360
      }
    end    
  end
end