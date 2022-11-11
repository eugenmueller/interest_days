# frozen_string_literal: true

RSpec.describe "InterestDays::Calculation::IcmaActAct", "#day_count_factor", type: :integration do
  subject(:calc) { InterestDays::Calculation::IcmaActAct.new(start_date: start_date, end_date: end_date) }

  let(:amount) { 10_000.00 }
  let(:interest) { 10.00 }

  describe "integration example normal year" do
    let(:start_date) { Date.new(1999, 2, 1) }
    let(:end_date) { Date.new(1999, 7, 1) }
    let(:days) { (end_date - start_date).to_i }

    it "calculates the interest with the right factor" do
      expectation = amount / 100 * interest * 150.fdiv(365)

      expect(amount / 100 * interest * calc.day_count_factor).to eql(expectation)
    end
  end

  describe "integration example leap year" do
    let(:start_date) { Date.new(1999, 7, 1) }
    let(:end_date) { Date.new(2000, 7, 1) }

    it "calculates the interest with the right factor" do
      expectation = amount / 100 * interest * (end_date - start_date).fdiv(366)

      expect(amount / 100 * interest * calc.day_count_factor).to eql(expectation)
    end
  end

  describe "integration example multiple years case 1" do
    let(:start_date) { Date.new(2000, 2, 1) }
    let(:end_date) { Date.new(2005, 7, 1) }

    let(:expectation) do
      start_date_period_factor = (366 - start_date.yday).fdiv(366)
      end_date_period_factor = end_date.yday.fdiv(365)
      years_factor = (end_date.year - start_date.year) - 1

      amount / 100 * interest * (start_date_period_factor + years_factor + end_date_period_factor)
    end

    it "calculates the interest with the right factor" do
      expect(amount / 100 * interest * calc.day_count_factor).to eql(expectation)
    end
  end

  describe "integration example multiple years case 2" do
    let(:start_date) { Date.new(2022, 1, 1) }
    let(:end_date) { Date.new(2024, 3, 2) }

    let(:expectation) do
      start_date_period_factor = (365 - start_date.yday).fdiv(365)
      end_date_period_factor = end_date.yday.fdiv(366)
      years_factor = (end_date.year - start_date.year) - 1

      amount / 100 * interest * (start_date_period_factor + years_factor + end_date_period_factor)
    end

    it "calculates the interest with the right factor" do
      expect(amount / 100 * interest * calc.day_count_factor).to eql(expectation)
    end
  end
end
