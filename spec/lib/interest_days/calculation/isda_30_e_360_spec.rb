# frozen_string_literal: true

RSpec.describe InterestDays::Calculation::Isda30e360 do # rubocop:disable Metrics/BlockLength
  describe "#calculate" do # rubocop:disable Metrics/BlockLength
    subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

    let(:days_in_year) { 360 }

    context "when in month with 30 days" do
      let(:start_date) { Date.new(2021, 4, 15) }
      let(:end_date) { Date.new(2021, 5, 1) }
      let(:days) { end_date - start_date }

      it "uses 30 days" do
        expect(calc.day_count_factor).to eq(days.fdiv(days_in_year))
      end
    end

    context "when in month with 31 days" do
      let(:start_date) { Date.new(2021, 1, 15) }

      context "when end_date is the 31st of the month" do
        let(:end_date) { Date.new(2021, 1, 31) }

        it "acts like the 31st is the 30th" do
          days = 30 - start_date.day # include start day
          expect(calc.day_count_factor).to eq(days.fdiv(days_in_year))
        end
      end

      context "when exceeding the 31st of the month" do
        let(:end_date) { Date.new(2021, 2, 1) }

        it "uses 30 days" do
          days = end_date - start_date - 1
          expect(calc.day_count_factor).to eq(days.fdiv(days_in_year))
        end
      end

      context "when end_date is the last day of February" do
        let(:days) { end_date - start_date }

        context "when February has 28 days" do
          let(:start_date) { Date.new(2021, 2, 15) }
          let(:end_date) { Date.new(2021, 2, 28) }

          it "uses the exact days" do
            expect(calc.day_count_factor).to eq(days.fdiv(days_in_year))
          end
        end

        context "when February has 29 days" do
          let(:start_date) { Date.new(2020, 2, 15) }
          let(:end_date) { Date.new(2020, 2, 29) }

          it "uses the exact days" do
            expect(calc.day_count_factor).to eq(days.fdiv(days_in_year))
          end
        end
      end

      context "when exceeding the last day of February" do
        let(:days) { 30 - start_date.day + 1 }

        context "when February has 28 days" do
          let(:start_date) { Date.new(2021, 2, 15) }
          let(:end_date) { Date.new(2021, 3, 1) }

          it "counts February as having 30 days" do
            expect(calc.day_count_factor).to eq(days.fdiv(days_in_year))
          end
        end

        context "when February has 29 days" do
          let(:start_date) { Date.new(2020, 2, 15) }
          let(:end_date) { Date.new(2020, 3, 1) }

          it "counts February as having 30 days" do
            expect(calc.day_count_factor).to eq(days.fdiv(days_in_year))
          end
        end
      end
    end
  end
end
