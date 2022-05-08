class CreateUserHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :user_histories do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :action, null: false
      t.boolean :status

      t.timestamps
    end
  end
end
