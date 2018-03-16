class Rate < ActiveRecord::Base
  def self.at(date, base_currency, counter_currency)
    return 1 if base_currency == counter_currency
    Rate.where(date: Date.parse(date), base_currency: base_currency,
               counter_currency: counter_currency).first.rate
  end
end
