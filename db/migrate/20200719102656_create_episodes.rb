class CreateEpisodes < ActiveRecord::Migration[6.0]
  def change
    create_table :episodes do |t|
      t.belongs_to :content, null: false
      t.string :title, null: false
      t.integer :number, null: false
      t.text :plot, null: false

      t.timestamps
    end

    add_index(:episodes, [:content_id, :number], unique: true)
  end
end
