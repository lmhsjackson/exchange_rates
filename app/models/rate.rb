class Rate < ActiveRecord::Base
  VALID_CURRENCY = ['SEK', 'NOK', 'EUR']

  def self.at(date, base_currency, counter_currency)
    return 1 if base_currency == counter_currency

    date = Date.parse date
    raise ArgumentError, 'Invalid date' if Date.today < date
    raise ArgumentError, 'Invalid currency' unless(VALID_CURRENCY.include?(base_currency) && VALID_CURRENCY.include?(counter_currency))
    search_result = Rate.where(date: date, base_currency: base_currency,
               counter_currency: counter_currency)
    raise ActiveRecord::RecordNotFound, 'no exchange rate was found for the data provided' if search_result.empty?
    search_result.first.rate
  end
end
