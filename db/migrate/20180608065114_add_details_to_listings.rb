class AddDetailsToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :name, :string
    add_column :listings, :place_type, :integer
    add_column :listings, :property_type, :string
    add_column :listings, :room_number, :integer
    add_column :listings, :bed_number, :integer
    add_column :listings, :guest_number, :integer
    add_column :listings, :country, :string
    add_column :listings, :state, :string
    add_column :listings, :city, :string
    add_column :listings, :zipcode, :integer
    add_column :listings, :price, :integer
    add_column :listings, :description, :string
  end
end
