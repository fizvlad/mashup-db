class IndexMashupAudioId < ActiveRecord::Migration[6.0]
  def change
    add_index :mashups, :audio_id, unique: true
  end
end
