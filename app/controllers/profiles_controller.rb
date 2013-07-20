# encoding: utf-8

class ProfilesController < ApplicationController

  before_filter :check_user_login
  before_filter :check_admin_user, :except => [:show, :edit, :update, :destroy]

  def index
    # @profiles = Profile.page(params[:page]).per(10).order(:id)
    # @profiles = Profile.where('user_id = :user_id', {:user_id => params[:id]}).page(params[:page]).per(10)
    @profiles = User.page(params[:page]).per(10)
  end

  def show
    if current_user? || admin_role?
      respondOne
    else
      redirect_to "/"
    end
  end

  def edit
    if current_user?
      respondOne
    else
      redirect_to "/"
    end
  end

  def update
    begin
      @profile = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid profile error#{params[:id]}"
      redirect_to "/", notice: 'プロフィールは存在しません'
    else
      if @profile.update_attributes(params[:user])
        redirect_to profile_path(@profile)
      else
        render action: 'edit'
      end
    end
  end

  def password
    if current_user?
      respondOne
    else
      redirect_to "/"
    end
  end

  def update_password
    begin
      @profile = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid profile error#{params[:id]}"
      redirect_to "/", notice: 'プロフィールは存在しません'
    else
      if params[:user][:password] == params[:user][:password_confirmation]
        @profile.password = params[:user][:password]
        @profile.password_confirmation = params[:user][:password_confirmation]
        if @profile.update_attributes(params[:user])
          redirect_to profile_path(@profile), notice: 'パスワードを変更しました'
        else
          render action: 'password'
        end
      else
        redirect_to "/profiles/" + @profile.id.to_s + "/edit/password", alert: 'パスワードが異なります'
      end
    end
  end

  def destroy
    if current_user?
      begin
        @profile = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        logger.error "Access invalid profile error#{params[:id]}"
        redirect_to profiles_path, notice: 'プロフィールは存在しません'
      else
        if @profile.destroy
          if (self.admin_role?)
            redirect_to profiles_path, notice: @profile.name + 'を削除しました'
          else
            redirect_to "/", notice: '退会しました'
          end
        else
          redirect_to "/", alert: 'エラーが発生しました'
        end
      end
    else
      redirect_to "/"
    end
  end

  private
  def respondOne
    begin
      @profile = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid profile error#{params[:id]}"
      redirect_to "/", notice: 'プロフィールは存在しません'
    else
      respond_to do |format|
        format.html
        # format.json {render json:@article}
      end
    end
  end

  def current_user?
    current_user && current_user.id.to_s == params[:id]
  end

  # def photoupload
  #   photo = Photo.new(:file => params[:qqfile])
  #   photo.save

  #   respond_to do |format|
  #     format.json {render json: ActiveSupport::JSON.encode({"url" => photo.file.url(:medium), "success" => true, "image" => ActiveSupport::JSON.decode(photo.to_json)})}
  #   end
  # end

end
