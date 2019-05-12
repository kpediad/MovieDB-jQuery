class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :movie_id
      t.text :content
      t.decimal :rating, precision: 2, scale: 1

      t.timestamps
    end
  end
end
