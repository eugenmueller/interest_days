# frozen_string_literal: true

RSpec.describe InterestDays::Calculation::IsdaAct365 do
  describe "#calculate" do
    let(:start_date) { Date.today }
    let(:end_date) { Date.today + 118 }

    subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

    it "calculate the right day count factor" do
      expectation = (end_date - start_date).fdiv(365)

      expect(calc.day_count_factor).to eql(expectation)
    end
  end
end
