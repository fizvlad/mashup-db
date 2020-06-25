class AddUsernameToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :username, :string, limit: 64
    add_index :users, :username, unique: true
  end
end
