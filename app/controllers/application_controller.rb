class ApplicationController < ActionController::Base
  require 'analytics/device_region'
  require 'analytics/visitor_logger_filter'
  require 'analytics/todays_photo_filter'
  include VisitorLoggerFilter
  include TodaysPhotoFilter

  protect_from_forgery

  # check auth admin role
  def admin_role?
      current_user && current_user.admin?
  end

  def check_admin_user
      if !admin_role?
        redirect_to "/"
      end
  end

  def check_user_login
      if !current_user
        redirect_to "/"
      end
  end

  def user_login?
      !!current_user
  end

  def imageupload
    image = Image.new(:file => params[:qqfile])
    image.save

    respond_to do |format|
      format.json {render json: ActiveSupport::JSON.encode({"url" => image.file.url(:medium), "success" => true, "image" => ActiveSupport::JSON.decode(image.to_json)})}
    end
  end

  def photoupload
    photo = Photo.new(:file => params[:qqfile])
    photo.save

    respond_to do |format|
      format.json {render json: ActiveSupport::JSON.encode({"url" => photo.file.url(:medium), "success" => true, "image" => ActiveSupport::JSON.decode(photo.to_json)})}
    end
  end

end
