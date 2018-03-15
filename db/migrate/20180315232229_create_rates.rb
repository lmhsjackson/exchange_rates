class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.string :base_currency
      t.string :counter_currency
      t.date :date
      t.float :rate

      t.timestamps null: false
    end
  end
end
