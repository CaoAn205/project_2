class Api::V1::Admin::BaseController < Api::V1::BaseController
  before_action :check_admin_permission

  def check_admin_permission
    return if current_user.admin?

    raise ActiveRecord::RecordNotFound
  end
end