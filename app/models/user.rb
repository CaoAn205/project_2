class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

  include DeviseTokenAuth::Concerns::User

  attr_writer :login

  before_validation :set_provider
  before_save :send_registration_password_email, if: :new_record?

  enum role_type: %i(admin user)
  has_many :images

  scope :admin, -> { where(role_type: 'admin') }


  def login
    @login || self.username || self.email
  end

  def set_provider
    self[:provider] = "email" if self[:provider].blank?
  end

  def assign_auto_genterated_password
    new_password = generate_password
    assign_attributes(password: new_password, password_confirmation: new_password)
  end

  def send_registration_password_email
    UserMailer.registration_email(email, password).deliver_later
  end

  def send_reset_password_email
    UserMailer.reset_password(email, password).deliver_later
  end

  private

  def generate_password
    3.times.map { ('a'..'z').to_a[rand(26)] + ('A'..'Z').to_a[rand(26)] + (0..9).map(&:to_s)[rand(10)] }.join
  end
end
