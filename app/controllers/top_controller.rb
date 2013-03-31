class TopController < ApplicationController
  TOP_NEWS_SIZE = 6
  TOP_NEWS_SIZE_OF_RECOMMENDATION = 3

  def index
    @articles = Article.where("approved = :approved", {:approved => true}).limit(TOP_NEWS_SIZE)
    @recommended_articles = Article.where("approved = :approved AND recommended = :recommended", {:approved => true, :recommended => true}).limit(TOP_NEWS_SIZE_OF_RECOMMENDATION)
  end
end
