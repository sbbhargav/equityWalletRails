class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :companyname
      t.integer :stockprice
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
