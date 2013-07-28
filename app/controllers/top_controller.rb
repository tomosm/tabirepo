class TopController < ApplicationController
  TOP_NEWS_SIZE = 4
  TOP_NEWS_SIZE_OF_RECOMMENDATION = 4

  def index
    @articles = Article.where("approved = :approved AND applied = :applied", {:approved => true, :applied => true}).limit(TOP_NEWS_SIZE)
    @recommended_articles = Article.where("approved = :approved AND recommended = :recommended AND applied = :applied", {:approved => true, :recommended => true, :applied => true}).limit(TOP_NEWS_SIZE_OF_RECOMMENDATION)

    # アクセスがないと人気順に表示されないので注意！
    @popular_articles = Article.where("articles.approved = :approved AND articles.applied = :applied", 
      {:approved => true, :applied => true}).with_popular.limit(TOP_NEWS_SIZE_OF_RECOMMENDATION)

    @theme_turningpoint = Theme.where("code = :code", {:code => "turningpoint"}).first
    @theme_heartful = Theme.where("code = :code", {:code => "heartful"}).first
    @theme_firsttime = Theme.where("code = :code", {:code => "firsttime"}).first
    @theme_dangerous = Theme.where("code = :code", {:code => "dangerous"}).first
    @theme_funny = Theme.where("code = :code", {:code => "funny"}).first
  end
end
