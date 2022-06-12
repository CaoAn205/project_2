class CreateImageSectors < ActiveRecord::Migration[6.1]
  def change
    create_table :image_sectors, id: false do |t|
      t.binary :id, limit: 36, primary_key: true, null: false
      t.binary :image_id, null: false, foreign_key: true
      t.binary :label_id, null: false, foreign_key: true
      t.longtext :area_data, null: false
      t.datetime :confirmed_at

      t.timestamps
    end
  end
end
