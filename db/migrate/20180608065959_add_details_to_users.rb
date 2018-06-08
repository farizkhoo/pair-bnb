class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :gender, :integer
    add_column :users, :phone, :string
    add_column :users, :country, :string
    add_column :users, :birthdate, :date
  end
end
