class Rate < ActiveRecord::Base
  def self.at(date, base_currency, counter_currency)
    Rate.where(date: date, base_currency: base_currency,
               counter_currency: counter_currency).first.rate
  end
end
