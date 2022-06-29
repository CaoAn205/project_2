class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_auth_info_to_cookie

  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  protect_from_forgery prepend: true, with: :exception, if: :verify_api

  def authenticate_current_user
    head :unauthorized if current_user_get.nil?
  end

  def current_user_get
    return nil unless cookies[:auth_headers]
    auth_headers = JSON.parse(cookies[:auth_headers])
    expiration_datetime = DateTime.strptime(auth_headers['expiry'], '%s')
    current_user = User.find_by(uid: auth_headers['uid'])

    if current_user &&
       current_user.tokens.key?(auth_headers['client']) &&
       expiration_datetime > DateTime.now
      @current_user = current_user
    end

    @current_user
  end

  def verify_api
    params[:controller].split('/')[0] != 'devise_token_auth'
  end

  def set_auth_info_to_cookie
    return if current_user.blank?

    if new_token_required?
      auth_header = current_user.create_new_auth_token(request.headers['client'])
      cookies[:authHeaders] = {
        value: JSON.generate(auth_header),
        expires: 14.days.from_now,
        secure: !Rails.env.development?,
      }
    end
  end

  def render_404
    respond_to do |format|
      format.json do
        render json: {
          success: false,
          error: {
            message: "Something goes wrong or you have no permission to perform this"
          }
        }
      end

      format.any do
        render file: Rails.root.join('public', '404.html'), status: :not_found, layout: false, content_type: 'text/html', formats: [:html]
      end
    end
  end

  private

  def new_token_required?
    cookies[:authHeaders].nil? && !requested_with_token?
  end

  def requested_with_token?
    request.headers['client'].present? &&
      request.headers['access-token'].present? &&
      request.headers['uid'].present?
  end
end
