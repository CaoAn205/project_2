class Api::V1::BaseController < ::ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken

  protect_from_forgery with: :null_session, prepend: true
  # skip_before_action :verify_authenticity_token
  # skip_before_action :authenticate_user!
end
