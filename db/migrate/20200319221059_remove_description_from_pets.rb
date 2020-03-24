class RemoveDescriptionFromPets < ActiveRecord::Migration[5.1]
  def change
    remove_column :pets, :description, :text
  end
end
