# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Rate.create([
  {
    base_currency: 'EUR',
    counter_currency: 'NOK',
    date: Date.today,
    rate: '9.5'
  },
  {
    base_currency: 'EUR',
    counter_currency: 'SEK',
    date: Date.today,
    rate: '10.07'
  }
])
