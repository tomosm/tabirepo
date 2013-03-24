class AboutUsController < ApplicationController
  def index
    @about_us = AboutUs.all(:order => "created_at DESC", :limit => 1)
  end
end
