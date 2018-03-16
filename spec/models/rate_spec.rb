require 'rails_helper'

RSpec.describe Rate, type: :model do
  fixtures :rates

  describe '.at' do
    let(:subject) { Rate }

    context 'date is present or past' do
      let(:date) { Date.today }

      context 'currencies are valid' do
        let(:base_currency) { 'SEK' }
        let(:counter_currency) { 'EUR' }

        it 'performs a where operation with given params' do
          allow(subject).to receive(:where).and_call_original
          rate = subject.at(date, base_currency, counter_currency)
          expect(subject).to have_received(:where).with(date: date, base_currency: base_currency, counter_currency: counter_currency)
        end

        it 'returns the expected rate' do
          expected_rate = subject.where(date: date, base_currency: base_currency, counter_currency: counter_currency).first.rate
          rate = subject.at(date, base_currency, counter_currency)
          expect(rate).to equal(expected_rate)
        end
      end

      context 'currencies are not supported/invalid' do
        let(:base_currency) { 'broken' }
        let(:counter_currency) { 'EUR' }
      end
    end

    context 'date is in the future' do
      it '' do
        # expect
      end
    end
  end
end
