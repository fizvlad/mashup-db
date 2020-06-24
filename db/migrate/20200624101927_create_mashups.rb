class CreateMashups < ActiveRecord::Migration[6.0]
  def change
    create_table :mashups do |t|
      t.integer :audio_id
      t.timestamps
    end
    add_foreign_key :mashups, :audios, on_update: :cascade, on_delete: :cascade
  end
end
