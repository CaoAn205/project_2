class Api::V1::ResetPasswordsController < Api::V1::BaseController
  protect_from_forgery with: :null_session

  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def create
    user = User.find_by(email: params[:email])
    raise ActiveRecord::RecordNotFound unless user.present?

    user.assign_auto_genterated_password
    user.send_reset_password_email
    user.save!

    render json: {
      success: true
    }
  end
end
