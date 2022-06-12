# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users, id: false do |t|
      t.binary :id, limit: 36, primary_key: true, null: false
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :users, :email, unique: true
  end
end
