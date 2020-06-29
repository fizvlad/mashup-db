class AddDateToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :date, :timestamp, default: Time.at(0).utc
  end
end
