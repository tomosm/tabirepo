# encoding: utf-8

class AboutUsController < ApplicationController
  def index
    @about_us = AboutUs.all(:order => "created_at DESC", :limit => 1)
  end

  def edit
    @about_us = AboutUs.all(:order => "created_at DESC", :limit => 1)
    respond_to do |format|
      format.html
      # format.json {render json:@article}
    end
  end

  def update
    begin
      @about_us = AboutUs.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid about us error#{params[:id]}"
      redirect_to "/", notice: '指定したデータは存在しません'
    else
      if @about_us.update_attributes(params[:about_us])
        redirect_to edit_about_us_path(@about_us) # todo 更新しました？
      else
        render action: 'edit'
      end
    end
  end

end
