class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[6.1]
  def change
    ## Required
    add_column :users, :provider, :string, null: false, default: "email"
    add_column :users, :uid, :string, null: false, default: ""

    ## Lockable
    add_column :users, :failed_attempts, :integer, default: 0, null: false
    add_column :users, :unlock_token, :string
    add_column :users, :locked_at, :datetime

    ## Tokens
    add_column :users, :tokens, :json


    add_index :users, [:uid, :provider], unique: true
    add_index :users, :unlock_token, unique: true
  end
end
