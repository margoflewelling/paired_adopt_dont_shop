class AddAddressToShelters < ActiveRecord::Migration[5.1]
  def change
    add_column :shelters, :address, :string
  end
end
