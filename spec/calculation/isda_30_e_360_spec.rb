# frozen_string_literal: true

RSpec.describe InterestDays::Calculation::Isda30e360 do
  describe "#calculate" do
    let(:start_date) { Date.today }
    let(:end_date) { Date.today + 128 }

    subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

    it "calculate the right day count factor" do
      expectation = (
        360 * (end_date.year - start_date.year) +
        30 * (end_date.month - start_date.month) +
        ([end_date.day, 30].min - [start_date.day, 30].min)
      ).fdiv(360)

      expect(calc.day_count_factor).to eql(expectation)
    end
  end
end
