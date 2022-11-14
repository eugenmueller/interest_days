# frozen_string_literal: true

RSpec.describe InterestDays::Calculation::IcmaActAct do # rubocop:disable Metrics/BlockLength
  subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

  describe "when start date in leap year" do
    let(:end_date) { Date.new(2021, 2, 3) }

    context "when 29th of february not in period" do
      let(:start_date) { Date.new(2020, 5, 3) }

      it "calculates the right day count factor" do
        expect(calc.day_count_factor).to eql((end_date - start_date).fdiv(described_class::DAYS_IN_YEAR))
      end
    end

    context "when 29th of february is in period" do
      let(:start_date) { Date.new(2020, 2, 3) }

      it "calculates the right day count factor" do
        expect(calc.day_count_factor).to eql((end_date - start_date).fdiv(described_class::DAYS_IN_LEAP_YEAR))
      end
    end
  end

  describe "when end_date in leap year" do
    let(:start_date) { Date.new(2019, 6, 1) }

    context "when 29th of february not in period" do
      let(:end_date) { Date.new(2020, 2, 3) }

      it "calculates the right day count factor" do
        expect(calc.day_count_factor).to eql((end_date - start_date).fdiv(described_class::DAYS_IN_YEAR))
      end
    end

    context "when 29th of february is in period" do
      let(:end_date) { Date.new(2020, 5, 3) }

      it "calculates the right day count factor" do
        expect(calc.day_count_factor).to eql((end_date - start_date).fdiv(described_class::DAYS_IN_LEAP_YEAR))
      end
    end
  end

  describe "when start_date and end_date in same year" do
    let(:end_date) { Date.new(2020, 12, 31) }

    context "when 29th of feburary is period" do
      let(:start_date) { Date.new(2020, 1, 1) }

      it "calculates the right day count factor" do
        expect(calc.day_count_factor).to eql((end_date - start_date).fdiv(described_class::DAYS_IN_LEAP_YEAR))
      end
    end

    context "when 29th of feburary is not in period" do
      let(:start_date) { Date.new(2020, 3, 1) }

      it "calculates the right day count factor" do
        expect(calc.day_count_factor).to eql((end_date - start_date).fdiv(described_class::DAYS_IN_YEAR))
      end
    end
  end

  describe "when start_date and end_date span over multiple years" do
    let(:start_date) { Date.new(2020, 1, 1) }
    let(:end_date) { Date.new(2026, 12, 30) }

    let(:expectation) do
      start_date_period_factor = (366 - start_date.yday).fdiv(366)
      end_date_period_factor = end_date.yday.fdiv(365)
      years_factor = (end_date.year - start_date.year) - 1

      start_date_period_factor + years_factor + end_date_period_factor
    end

    it "calculates the right factor" do
      expect(calc.day_count_factor).to eql(expectation)
    end
  end
end
