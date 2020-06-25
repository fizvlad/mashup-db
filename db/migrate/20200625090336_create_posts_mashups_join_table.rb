class CreatePostsMashupsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :posts, :mashups
  end
end
