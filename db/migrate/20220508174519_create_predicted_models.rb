class CreatePredictedModels < ActiveRecord::Migration[6.1]
  def change
    create_table :predicted_models do |t|
      t.string :name, null: false
      t.string :symbol, null: false
      t.string :rgb_code, null: false
      t.float :accuracy_rate

      t.timestamps
    end
  end
end
