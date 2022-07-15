class CreateImageMasks < ActiveRecord::Migration[6.1]
  def change
    create_table :image_masks, id: false do |t|
      t.binary :id, limit: 36, primary_key: true, null: false
      t.binary :image_id, null: false, foreign_key: true
      t.string :file

      t.timestamps
    end
  end
end
