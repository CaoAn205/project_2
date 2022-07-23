class Api::V1::ProfileController < Api::V1::BaseController
  def index
    render json: {
      success: true,
      data: UserSerializer.new(current_user)
    }
  end

  def update
    current_user.update!(profile_name_and_email_params)

    render json: {
      success: true,
      user: UserSerializer.new(current_user)
    }, status: :accepted
  end

  def change_password
    if current_user.valid_password?(params[:old_password])
      current_user.update!(profile_password_params)
    else
      raise ActiveRecord::RecordNotFound
    end

    render json: {
      success: true
    }, status: :accepted
  end

  private

  def profile_name_and_email_params
    params.require(:profile).permit(:name, :email)
  end

  def profile_password_params
    params.require(:profile).permit(:password, :password_confirmation)
  end
end
