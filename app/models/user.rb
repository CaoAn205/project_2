class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  before_validation :set_provider

  enum role_type: %i(admin user)
  has_many :images

  scope :admin, -> { where(role_type: 'admin') }

  def set_provider
    self[:provider] = "email" if self[:provider].blank?
  end
end
