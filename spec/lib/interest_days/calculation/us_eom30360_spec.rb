# frozen_string_literal: true

RSpec.describe InterestDays::Calculation::UsEom30360 do
  describe "#calculates" do
    context "when normal year" do
      subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

      let(:start_date) { Date.new(2019, 1, 4) }
      let(:end_date) { Date.new(2019, 12, 14) }

      it "calculates the right day count factor" do
        expectation = 0.9444444444444444

        expect(calc.day_count_factor).to eql(expectation)
      end
    end

    context "when leap year" do
      subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

      let(:start_date) { Date.new(2000, 1, 31) }
      let(:end_date) { Date.new(2000, 12, 30) }

      it "calculates the right day count factor" do
        expectation = 0.9166666666666666

        expect(calc.day_count_factor).to eql(expectation)
      end
    end

    context "when start in february" do
      subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

      let(:start_date) { Date.new(2000, 2, 1) }
      let(:end_date) { Date.new(2000, 2, 29) }

      it "calculates the right day count factor" do
        expectation = 0.07777777777777778

        expect(calc.day_count_factor).to eql(expectation)
      end
    end
  end
end
