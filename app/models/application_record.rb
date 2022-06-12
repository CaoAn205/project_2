class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  before_create :set_uuid

  def set_uuid
    self.id = SecureRandom.uuid
  end
end
