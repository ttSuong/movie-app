class CreateMoviesUsersJoinTable < ActiveRecord::Migration[5.2]
  def change
    create_table :movie_users do |t|
      t.belongs_to :user
      t.belongs_to :movie
      t.string :type_reaction
      t.timestamps
    end

    add_index :movie_users, [:user_id, :movie_id], name: :movie_user_index, unique: true
  end
end
