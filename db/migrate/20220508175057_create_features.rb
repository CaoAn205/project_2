class CreateFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :features do |t|
      t.references :image_attachment, null: false, foreign_key: true
      t.references :predicted_model, null: false, foreign_key: true
      t.longtext :data

      t.timestamps
    end
  end
end
