class CreateMashupsAudiosJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :mashups, :audios
  end
end
