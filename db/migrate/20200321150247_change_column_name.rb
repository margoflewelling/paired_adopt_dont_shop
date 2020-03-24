class ChangeColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :pets, :image_path, :image
  end
end
