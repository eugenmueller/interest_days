# frozen_string_literal: true

RSpec.describe InterestDays::Calculation::UsEom30360 do
  describe "#calculate" do
    context "when normal year" do
      let(:start_date) { Date.new(2019, 1, 4) }
      let(:end_date) { Date.new(2019, 12, 14) }

      subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

      it "calculate the right day count factor" do
        expectation = 0.9444444444444444

        expect(calc.day_count_factor).to eql(expectation)
      end
    end

    context "when leap year" do
      let(:start_date) { Date.new(2000, 1, 4) }
      let(:end_date) { Date.new(2000, 12, 14) }

      subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

      it "calculate the right day count factor" do
        expectation = 0.9444444444444444

        expect(calc.day_count_factor).to eql(expectation)
      end
    end
  end
end
