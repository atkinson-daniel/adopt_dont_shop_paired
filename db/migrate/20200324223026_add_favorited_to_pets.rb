class AddFavoritedToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :favorited, :boolean
  end
end
