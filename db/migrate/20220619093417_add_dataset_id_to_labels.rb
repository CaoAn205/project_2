class AddDatasetIdToLabels < ActiveRecord::Migration[6.1]
  def change
    add_column :labels, :dataset_id, :binary, null: false, foreign_key: true
  end
end
