class AddListingCoverToListings < ActiveRecord::Migration[5.2]
  def change
    add_column :listings, :listing_cover, :string
  end
end
