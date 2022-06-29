class Api::V1::Admin::UsersController < Api::V1::Admin::BaseController
  def index
    render json: {
      success: true,
      data: ActiveModel::Serializer::CollectionSerializer.new(
        User.all, serializer: UserSerializer
      )
    }
  end

  def create
    user = User.new(user_params)
    user.assign_auto_genterated_password
    user.save!

    render json: {
      success: true,
      data: ::UserSerializer.new(user)
    }
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!

    render json: {
      success: true
    }, status: :accepted
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :role_type)
  end
end
