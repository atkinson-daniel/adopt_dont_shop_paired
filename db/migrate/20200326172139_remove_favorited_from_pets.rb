class RemoveFavoritedFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :favorited, :boolean
  end
end
