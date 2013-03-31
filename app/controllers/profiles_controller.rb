# encoding: utf-8

class ProfilesController < ApplicationController

  before_filter :authenticate_admin_role, :except => [:show, :edit, :update, :destroy]

  def index
    # @profiles = Profile.page(params[:page]).per(10).order(:id)
    # @profiles = Profile.where('user_id = :user_id', {:user_id => params[:id]}).page(params[:page]).per(10)
    @profiles = User.page(params[:page]).per(10)
  end

  def show
    respondOne
  end

  def edit
    respondOne
  end

  def update
    begin
      @profile = Profile.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid profile error#{params[:id]}"
      redirect_to "/", notice: 'プロフィールは存在しません'
    else
      if @profile.update_attributes(params[:profile])
        redirect_to profile_path(@profile)
      else
        render action: 'edit'
      end
    end
  end

  def destroy
    begin
      @profile = Profile.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid profile error#{params[:id]}"
      redirect_to profiles_path, notice: 'プロフィールは存在しません'
    else
      @profile.destroy
      # admin なら profiles_path
      # admin でないならcookieから削除してtopへ
      redirect_to profiles_path
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

end
