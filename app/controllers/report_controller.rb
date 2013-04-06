# encoding: utf-8

class ReportController < ApplicationController
  layout 'admin'

  def index
    # @analytics_articles = AnalyticsArticle.group(:article_id).group(:date).group(:deviceregion).group(:visitorregion).includes(:article).all
    @analytics_articles_date = AnalyticsArticle
      .group(:date).all
    @analytics_articles_new = AnalyticsArticle
      .count_by_date(AnalyticsVisitor::VISITOR_REGION_NEW)
    @analytics_articles_repeater = AnalyticsArticle
      .count_by_date(AnalyticsVisitor::VISITOR_REGION_REPEATER)


    @categories = []
    @newer = []
    @repeater = []
    @analytics_articles_date.each do |article|
      @categories << Time.at(article.date).to_date
      @newer << (@analytics_articles_new[article.date] || 0)
      @repeater << (@analytics_articles_repeater[article.date] || 0)
    end



    # # @end_at = Time.at(@analytics_articles_date.last.date)
    # # @start_at = Time.at(@analytics_articles_date.first.date)
    # @categories = @@analytics_articles.select {|article| }
    # @categories = @analytics_articles_date.map {|item| Time.at(item.date)}

    @chart = LazyHighCharts::HighChart.new("graph") do |f|
      f.chart(:type => "line")
      f.title(:text => "訪問数")
      f.xAxis(:categories => @categories)
      f.series(:name => "新規", :data => @newer)
      f.series(:name => "リピート", :data => @repeater)
    end


  end

end
