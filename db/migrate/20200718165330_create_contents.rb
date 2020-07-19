class CreateContents < ActiveRecord::Migration[6.0]
  def change
    create_table :contents do |t|
      t.integer :content_type, null: false
      t.string :title, unique: true, null: false
      t.text :plot, null:false
      t.integer :number

      t.timestamps
    end

    add_index(:contents, :content_type)
    add_index(:contents, [:title, :number], unique: true)
  end
end
