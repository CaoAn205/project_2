class CreateImageAttachments < ActiveRecord::Migration[6.1]
  def change
    create_table :image_attachments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :file, null: false
      t.string :file_name
      t.float :file_size

      t.timestamps
    end
  end
end
