class AddColumnVideo < ActiveRecord::Migration[5.2]
  def change
    add_column :movies, :url_id, :string
    add_column :movies, :is_sharing, :boolean
    add_column :movies, :provider, :string
  end
end
