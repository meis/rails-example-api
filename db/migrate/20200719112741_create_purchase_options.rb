class CreatePurchaseOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_options do |t|
      t.references :content, null: false, foreign_key: true
      t.integer :quality
      t.decimal :price, precision: 6, scale: 2

      t.timestamps
    end

    add_index(:purchase_options, [:content_id, :quality], unique: true)
  end
end
