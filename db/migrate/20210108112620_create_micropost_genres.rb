class CreateMicropostGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :micropost_genres do |t|
      t.references :micropost, null: false, foreign_key: true
      t.references :genre, null: false, foreign_key: true

      t.timestamps
      t.index [:micropost_id, :genre_id], unique: true
    end
  end
end
