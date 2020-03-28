class AddAcceptedAppIdToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :accepted_app_id, :string
  end
end
