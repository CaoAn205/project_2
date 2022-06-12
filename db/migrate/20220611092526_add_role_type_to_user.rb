class AddRoleTypeToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :role_type, :integer, default: 1
  end
end
