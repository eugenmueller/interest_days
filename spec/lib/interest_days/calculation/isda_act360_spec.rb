# frozen_string_literal: true

RSpec.describe InterestDays::Calculation::IsdaAct360 do
  describe "#calculate" do
    subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

    let(:start_date) { Date.today }
    let(:end_date) { Date.today + 78 }

    it "calculates the right day count factor" do
      expectation = (end_date - start_date).fdiv(360)

      expect(calc.day_count_factor).to eql(expectation)
    end
  end
end
