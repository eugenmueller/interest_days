RSpec.describe InterestDays::Calculator do
  let(:start_date) { Date.today }
  let(:end_date) { Date.today + 118 }

  let(:calculator) { described_class.new(start_date: start_date, end_date: end_date, strategy: strategy) }

  describe '#interest_day_count_factor' do
    let(:strategy) { :isda_act_360 }

    it { expect(calculator).to respond_to(:interest_day_count_factor)}
    it { expect(calculator.interest_day_count_factor).to be_instance_of(Float) }
  end

  describe 'isda act 360 strategy based calculation' do
    let(:strategy) { :isda_act_360 }
    
    it { expect(calculator.strategy).to be(InterestDays::Calculation::IsdaAct360) }
  end

  describe 'isda act 365 strategy based calculation' do
    let(:strategy) { :isda_act_365 }
    
    it { expect(calculator.strategy).to be(InterestDays::Calculation::IsdaAct365) }
  end

  describe 'isda 30 e 360 strategy based calculation' do
    let(:strategy) { :isda_30_e_360 }
    
    it { expect(calculator.strategy).to be(InterestDays::Calculation::Isda30e360) }
  end
end
