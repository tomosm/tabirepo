class TopController < ApplicationController
  TOP_NEWS_SIZE = 6
  TOP_NEWS_SIZE_OF_RECOMMENDATION = 3

  def index
    @articles = Article.where("approved = :approved", {:approved => true}).limit(TOP_NEWS_SIZE)
    @recommended_articles = Article.where("approved = :approved AND recommended = :recommended", {:approved => true, :recommended => true}).limit(TOP_NEWS_SIZE_OF_RECOMMENDATION)

    # アクセスがないと人気順に表示されないので注意！
    reader_article_id_list_by_popular_article = Reader.find_by_popular_article();
    @popular_articles = Article.where("id IN (:article_id_list) AND approved = :approved", 
      {:article_id_list => reader_article_id_list_by_popular_article.keys, :approved => true})
    .limit(TOP_NEWS_SIZE_OF_RECOMMENDATION)

  end
end
