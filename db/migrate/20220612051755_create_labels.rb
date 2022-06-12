class CreateLabels < ActiveRecord::Migration[6.1]
  def change
    create_table :labels, id: false do |t|
      t.binary :id, limit: 36, primary_key: true, null: false
      t.string :category_name, null: false
      t.string :color_code, null: false
      t.string :category_code, null: false

      t.timestamps
    end
  end
end
