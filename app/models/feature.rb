class Feature < ApplicationRecord
  belongs_to :image_attachment
  belongs_to :predicted_model
end
