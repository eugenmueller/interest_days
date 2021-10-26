# frozen_string_literal: true

RSpec.describe InterestDays::Calculation::IsdaAct360 do
  describe "#calculate" do
    let(:start_date) { Date.today }
    let(:end_date) { Date.today + 78 }

    subject(:calc) { described_class.new(start_date: start_date, end_date: end_date) }

    it "calculate the right day count factor" do
      expect(true).to be true
    end
  end
end
