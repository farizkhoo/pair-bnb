class FixListings < ActiveRecord::Migration[5.2]
  def change
  	rename_column :listings, :users_id, :user_id
  end
end
