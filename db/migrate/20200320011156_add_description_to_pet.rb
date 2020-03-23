class AddDescriptionToPet < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :description, :string
  end
end
