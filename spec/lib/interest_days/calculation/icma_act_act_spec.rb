# frozen_string_literal: true

RSpec.describe InterestDays::Calculation::IcmaActAct do # rubocop:disable Metrics/BlockLength
  describe "#day_count_factor" do # rubocop:disable Metrics/BlockLength
    subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

    context "when start date in leap year" do
      let(:end_date) { Date.new(2021, 2, 3) }

      context "when 29th of february not in period" do
        let(:start_date) { Date.new(2020, 5, 3) }

        it "calculate the right day count factor" do
          expectation = (end_date - start_date).fdiv(described_class::DAYS_IN_YEAR)

          expect(calc.day_count_factor).to eql(expectation)
        end
      end

      context "when 29th of february is in period" do
        let(:start_date) { Date.new(2020, 2, 3) }

        it "calculate the right day count factor" do
          expectation = (end_date - start_date).fdiv(described_class::DAYS_IN_LEAP_YEAR)

          expect(calc.day_count_factor).to eql(expectation)
        end
      end
    end

    context "when end_date in leap year" do
      let(:start_date) { Date.new(2019, 6, 1) }

      context "when 29th of february not in period" do
        let(:end_date) { Date.new(2020, 2, 3) }

        it "calculate the right day count factor" do
          expectation = (end_date - start_date).fdiv(described_class::DAYS_IN_YEAR)

          expect(calc.day_count_factor).to eql(expectation)
        end
      end

      context "when 29th of february is in period" do
        let(:end_date) { Date.new(2020, 5, 3) }

        it "calculate the right day count factor" do
          expectation = (end_date - start_date).fdiv(described_class::DAYS_IN_LEAP_YEAR)

          expect(calc.day_count_factor).to eql(expectation)
        end
      end
    end

    context "when start_date and end_date in same year" do
      context "when year is a leap year" do
        context "when 29th of feburary is period" do
          let(:start_date) { Date.new(2020, 1, 1) }
          let(:end_date) { Date.new(2020, 12, 31) }

          it "calculate the right day count factor" do
            expectation = (end_date - start_date).fdiv(described_class::DAYS_IN_LEAP_YEAR)

            expect(calc.day_count_factor).to eql(expectation)
          end
        end

        context "when 29th of feburary is not in period" do
          let(:start_date) { Date.new(2020, 3, 1) }
          let(:end_date) { Date.new(2020, 12, 31) }

          it "calculate the right day count factor" do
            expectation = (end_date - start_date).fdiv(described_class::DAYS_IN_YEAR)

            expect(calc.day_count_factor).to eql(expectation)
          end
        end
      end
    end

    context "when start_date and end_date span over multiple years" do
      let(:start_date) { Date.new(2020, 1, 1) }
      let(:end_date) { Date.new(2026, 12, 30) }

      it "calculate the right factor" do
        start_date_period_factor =
          (described_class::DAYS_IN_LEAP_YEAR - start_date.yday).fdiv(described_class::DAYS_IN_LEAP_YEAR)
        end_date_period_factor = end_date.yday.fdiv(described_class::DAYS_IN_YEAR)
        years_factor = (end_date.year - start_date.year) - 1

        expectation = start_date_period_factor + years_factor + end_date_period_factor

        expect(calc.day_count_factor).to eql(expectation)
      end
    end

    describe "integration example normal year" do
      let(:start_date) { Date.new(1999, 2, 1) }
      let(:end_date) { Date.new(1999, 7, 1) }

      let(:days) { (end_date - start_date).to_i }
      let(:amount) { 10_000.00 }

      let(:interest) { 10.00 }

      it "calculate the interest with the right factor" do
        expectation = amount / 100 * interest * 150.fdiv(described_class::DAYS_IN_YEAR)

        expect(amount / 100 * interest * calc.day_count_factor).to eql(expectation)
      end
    end

    describe "integration example leap year" do
      let(:start_date) { Date.new(1999, 7, 1) }
      let(:end_date) { Date.new(2000, 7, 1) }

      let(:days) { (end_date - start_date).to_i }
      let(:amount) { 10_000.00 }

      let(:interest) { 10.00 }

      it "calculate the interest with the right factor" do
        expectation = amount / 100 * interest * (end_date - start_date).fdiv(described_class::DAYS_IN_LEAP_YEAR)

        expect(amount / 100 * interest * calc.day_count_factor).to eql(expectation)
      end
    end

    describe "integration example multiple years" do
      let(:start_date) { Date.new(2000, 2, 1) }
      let(:end_date) { Date.new(2005, 7, 1) }

      let(:days) { (end_date - start_date).to_i }
      let(:amount) { 10_000.00 }

      let(:interest) { 10.00 }

      it "calculate the interest with the right factor" do
        start_date_period_factor =
          (described_class::DAYS_IN_LEAP_YEAR - start_date.yday).fdiv(described_class::DAYS_IN_LEAP_YEAR)
        end_date_period_factor = end_date.yday.fdiv(described_class::DAYS_IN_YEAR)
        years_factor = (end_date.year - start_date.year) - 1

        day_count_factor = start_date_period_factor + years_factor + end_date_period_factor
        expectation = amount / 100 * interest * day_count_factor

        expect(amount / 100 * interest * calc.day_count_factor).to eql(expectation)
      end
    end
  end
end
