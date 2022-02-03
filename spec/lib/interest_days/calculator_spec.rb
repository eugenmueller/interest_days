# frozen_string_literal: true

RSpec.describe InterestDays::Calculator do
  let(:start_date) { Date.today }
  let(:end_date) { Date.today + 360 }
  let(:calculator) { described_class.new(start_date: start_date, end_date: end_date, strategy: strategy) }

  describe "#interest_day_count_factor" do
    let(:strategy) { :isda_act_360 }

    it { expect(calculator).to respond_to(:interest_day_count_factor) }
    it { expect(calculator.interest_day_count_factor).to be(1.0) }
  end

  describe "isda act 360 strategy based calculation" do
    let(:strategy) { :isda_act_360 }

    it { expect(calculator.strategy).to be(InterestDays::Calculation::IsdaAct360) }
  end

  describe "isda act 364 strategy based calculation" do
    let(:strategy) { :isda_act_364 }

    it { expect(calculator.strategy).to be(InterestDays::Calculation::IsdaAct364 ) }
  end

  describe "isda act 365 strategy based calculation" do
    let(:strategy) { :isda_act_365 }

    it { expect(calculator.strategy).to be(InterestDays::Calculation::IsdaAct365) }
  end

  describe "isda 30 e 360 strategy based calculation" do
    let(:strategy) { :isda_30_e_360 }

    it { expect(calculator.strategy).to be(InterestDays::Calculation::Isda30e360) }
  end

  describe "us_eom_30_360 strategy based calculation" do
    let(:strategy) { :us_eom_30_360 }

    it { expect(calculator.strategy).to be(InterestDays::Calculation::UsEom30360) }
  end
  describe "bond_basis_30_360 strategy based calculation" do
    let(:strategy) { :bond_basis_30_360 }

    it { expect(calculator.strategy).to be(InterestDays::Calculation::Isda30e360) }
  end

  describe "when strategy not available" do
    let(:strategy) { :foo }

    it { expect(calculator.strategy).to be_nil }
    it { expect { calculator.interest_day_count_factor }.to raise_error }
  end
end
