class ApplicationController < ActionController::Base
  protect_from_forgery

  # check auth admin role
  def authenticate_admin_role
      current_user && current_user.admin?
  end

end
