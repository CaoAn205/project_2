class CreateDatasets < ActiveRecord::Migration[6.1]
  def change
    create_table :datasets, id: false do |t|
      t.binary :id, limit: 36, primary_key: true, null: false
      t.string :name, null: false
      t.integer :images_count
      t.integer :labels_count

      t.timestamps
    end
  end
end
