# frozen_string_literal: true

RSpec.describe InterestDays::Calculation::IsdaActAct do # rubocop:disable Metrics/BlockLength
  describe "#day_count_factor" do # rubocop:disable Metrics/BlockLength
    context "when start date in leap year" do
      let(:start_date) { Date.new(2020, 5, 3) }
      let(:end_date) { Date.new(2021, 2, 3) }

      subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

      it "calculates the right day count factor" do
        year_fraction_end = end_date.yday.fdiv(365)
        year_fraction_start = (366 - start_date.yday).fdiv(366)
        expectation = year_fraction_end + year_fraction_start

        expect(calc.day_count_factor).to eql(expectation)
      end
    end

    context "when end date in leap year" do
      let(:start_date) { Date.new(2019, 5, 3) }
      let(:end_date) { Date.new(2020, 2, 3) }

      subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

      it "calculates the right day count factor" do
        year_fraction_end = end_date.yday.fdiv(366)
        year_fraction_start = (365 - start_date.yday).fdiv(365)
        expectation = year_fraction_end + year_fraction_start

        expect(calc.day_count_factor).to eql(expectation)
      end
    end

    context "when end and start date not in leap year" do
      let(:start_date) { Date.new(2019, 1, 3) }
      let(:end_date) { Date.new(2019, 7, 3) }

      subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

      it "calculates the right day count factor" do
        expectation = (end_date - start_date).fdiv(365)

        expect(calc.day_count_factor).to eql(expectation)
      end
    end

    context "when end and start date in leap year" do
      let(:start_date) { Date.new(2020, 1, 3) }
      let(:end_date) { Date.new(2020, 7, 3) }

      subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

      it "calculates the right day count factor" do
        expectation = (end_date - start_date).fdiv(366)

        expect(calc.day_count_factor).to eql(expectation)
      end
    end

    context "when leap year between start and end date" do
      let(:start_date) { Date.new(2019, 1, 3) }
      let(:end_date) { Date.new(2021, 7, 3) }

      subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

      it "calculates the right day count factor" do
        year_fraction_end = end_date.yday.fdiv(365)
        year_between = 366.fdiv(366)
        year_fraction_start = (365 - start_date.yday).fdiv(365)

        expectation = year_fraction_end + year_between + year_fraction_start

        expect(calc.day_count_factor).to eql(expectation)
      end
    end

    context "when start date after end date" do
      let(:start_date) { Date.new(2020, 1, 3) }
      let(:end_date) { Date.new(2019, 7, 3) }

      subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

      it { expect { calc.day_count_factor }.to raise_error(InterestDays::Calculation::StartDateBeforeEndDateError) }
    end
  end

  describe "#start_date_after_end_date?" do
    let(:start_date) { Date.new(2020, 5, 3) }
    let(:end_date) { Date.new(2021, 2, 3) }

    subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

    it { expect(calc.send(:start_date_after_end_date?)).to be false }
  end

  describe "#days" do
    let(:start_date) { Date.new(2020, 5, 3) }
    let(:end_date) { Date.new(2021, 2, 3) }

    subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

    it { expect(calc.send(:days)).to eq(end_date - start_date) }
  end
end
