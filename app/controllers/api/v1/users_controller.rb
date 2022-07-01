class Api::V1::UsersController < Api::V1::BaseController
  def index
    render json: {
      success: true,
      data: ActiveModel::Serializer::CollectionSerializer.new(
        User.all, serializer: UserSerializer
      )
    }
  end

  def show
    user = User.find(params[:id])

    render json: {
      success: true,
      data: UserSerializer.new(user)
    }
  end
end
