class CreatePrices < ActiveRecord::Migration[7.1]
  def change
    create_table :prices do |t|
      t.string :item, null: false
      t.string :day, null: false
      t.string :month, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :unit, null: false
      t.datetime :recorded_at

      t.timestamps
    end
    
    add_index :prices, :item
    add_index :prices, :month
    add_index :prices, :day
    add_index :prices, [:item, :day], unique: true
  end
end