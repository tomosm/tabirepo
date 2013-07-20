class TopController < ApplicationController
  TOP_NEWS_SIZE = 4
  TOP_NEWS_SIZE_OF_RECOMMENDATION = 4

  def index
    @articles = Article.where("approved = :approved, applied = :applied", {:approved => true, :applied => true}).limit(TOP_NEWS_SIZE)
    @recommended_articles = Article.where("approved = :approved AND recommended = :recommended", {:approved => true, :recommended => true}).limit(TOP_NEWS_SIZE_OF_RECOMMENDATION)

    # アクセスがないと人気順に表示されないので注意！
    reader_article_id_list_by_popular_article = Reader.find_by_popular_article();
    @popular_articles = Article.where("id IN (:article_id_list) AND approved = :approved", 
      {:article_id_list => reader_article_id_list_by_popular_article.keys, :approved => true})
    .limit(TOP_NEWS_SIZE_OF_RECOMMENDATION)

    @theme_turningpoint = Theme.where("code = :code", {:code => "turningpoint"}).first
    @theme_heartful = Theme.where("code = :code", {:code => "heartful"}).first
    @theme_firsttime = Theme.where("code = :code", {:code => "firsttime"}).first
    @theme_dangerous = Theme.where("code = :code", {:code => "dangerous"}).first
    @theme_funny = Theme.where("code = :code", {:code => "funny"}).first
  end
end
