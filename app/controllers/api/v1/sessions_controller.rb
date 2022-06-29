class Api::V1::SessionsController < DeviseTokenAuth::SessionsController
  protect_from_forgery with: :null_session
  # wrap_parameters format: []

  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user!

  def new
    super
  end

  def create
    super
  end

  def destroy
    super
  end
end