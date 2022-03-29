# frozen_string_literal: true

RSpec.describe InterestDays::Calculation::IsdaActAct do
  describe "#calculate" do
    subject(:calc) { described_class.new(start_date: start_date, end_date: end_date).day_count_factor }

    context 'with in same year' do
      let(:start_date) { Date.parse("2022-03-31") }
      let(:end_date) { Date.parse("2022-10-01")}

      it { is_expected.to eql(184/365r) }
    end

    context 'with no leap year' do
      let(:start_date) { Date.parse("2022-03-31") }
      let(:end_date) { Date.parse("2023-04-01")}

      it { is_expected.to eql(366/365r) }
    end

    context 'with start in leap year' do
      let(:start_date) { Date.parse("2020-03-31") }
      let(:end_date) { Date.parse("2021-04-01")}

      it { is_expected.to eql(276/366r + 90/365r) }
    end

    context 'with end in leap year' do
      let(:start_date) { Date.parse("2019-03-31") }
      let(:end_date) { Date.parse("2020-04-01")}

      it { is_expected.to eql(276/365r + 91/366r) }
    end

    context 'with two leap years' do
      let(:start_date) { Date.parse("2020-03-31") }
      let(:end_date) { Date.parse("2025-04-01")}

      it { is_expected.to eql(276/366r + 1 + 1 + 1 + 1 + 90/365r) }
    end
  end
end
