class TopController < ApplicationController
  TOP_NEWS_SIZE = 9

  def index
    @articles = Article.all(:order => "created_at DESC", :limit => TOP_NEWS_SIZE)
  end
end
