class CreateReviewFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :review_favorites do |t|
      t.integer :review_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
