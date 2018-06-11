class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :location
      t.string :tags
      t.references :users, foreign_key: true

      t.timestamps
    end
  end
end
