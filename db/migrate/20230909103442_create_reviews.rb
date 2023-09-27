class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.integer :user_id, null: false
      t.string :facility_name, null: false
      t.string :post_code, null: false
      t.string :address, null: false
      t.text :text, null: false
      t.float :rating
      t.float :latitude
      t.float :longitude
      t.timestamps
    end
  end
end
