require 'rails_helper'

RSpec.describe Rate, type: :model do
  fixtures :rates

  describe '.at' do
    context 'date is present or past' do
      let(:date) { Date.today }

      context 'currencies are valid' do
        it '' do
          # expect
        end
      end

      context 'currencies are not supported/invalid' do

      end
    end

    context 'date is in the future' do
      it '' do
        # expect
      end
    end
  end
end
