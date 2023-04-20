class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :url
      t.integer :total_liked
      t.integer :total_disliked
      t.string :shared_by
      t.text :description

      t.timestamps
    end
  end
end
