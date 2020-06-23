class CreateAudiosAndArtists < ActiveRecord::Migration[6.0]
  def change
    create_table :artists do |t|
      t.string :name
      t.timestamps
    end

    create_table :audios do |t|
      t.string :title
      t.integer :artist_id
      t.timestamps
    end

    add_foreign_key :audios, :artists, on_update: :cascade, on_delete: :cascade
  end
end
