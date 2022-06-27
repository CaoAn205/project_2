class Api::V1::UsersController < Api::V1::BaseController
  def update
    user = User.find(params[:id])
    user.update!(user_params)

    render json: {
      success: true,
    }, status: :accepted
  end

  private

  def user_params
    params.require(:user).permit(:email, :name)
  end
end
