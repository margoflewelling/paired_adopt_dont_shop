class AddPathToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :image_path, :string
  end
end
