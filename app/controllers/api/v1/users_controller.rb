class Api::V1::UsersController < Api::V1::BaseController
  def show
    user = User.find(params[:id])

    render json: {
      success: true,
      data: UserSerializer.new(user)
    }
  end

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
