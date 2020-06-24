class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.integer :from_club, null: true, defaut: nil
      t.integer :from_user, null: true, defaut: nil

      t.timestamps
    end
    change_column :posts, :id, :integer, auto_increment: false
  end
end
