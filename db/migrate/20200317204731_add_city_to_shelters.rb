class AddCityToShelters < ActiveRecord::Migration[5.1]
  def change
    add_column :shelters, :city, :string
  end
end
