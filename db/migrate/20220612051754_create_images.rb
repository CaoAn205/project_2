class CreateImages < ActiveRecord::Migration[6.1]
  def change
    create_table :images, id: false do |t|
      t.binary :id, limit: 36, primary_key: true, null: false
      t.binary :user_id, null: false, foreign_key: true
      t.binary :dataset_id, null: false, foreign_key: true
      t.string :file, null: false

      t.timestamps
    end
  end
end
