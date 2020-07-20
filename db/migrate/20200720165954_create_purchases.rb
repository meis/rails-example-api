class CreatePurchases < ActiveRecord::Migration[6.0]
  def change
    create_table :purchases do |t|
      t.references :user, null: false, foreign_key: true
      t.references :purchase_option, null: false, foreign_key: true
      t.datetime :expiry_date, precision: 6, null: false

      t.timestamps
    end
  end
end
