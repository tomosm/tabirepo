# encoding: utf-8

class ReportController < ApplicationController
  before_filter :check_admin_user

  layout 'admin'

  def visitor
    @visitor_date = Visitor.group(:date).all
    @visitor_all = Visitor.count_by_date
    @visitor_new = Visitor.count_by_date(Visitor::VISITOR_REGION_NEW)
    @visitor_repeater = Visitor.count_by_date(Visitor::VISITOR_REGION_REPEATER)

    @reports = []
    @categories = []
    @all = []
    @newer = []
    @repeater = []
    @visitor_date.each do |visitor|
      @categories << Time.at(visitor.date).to_date
      @all << (@visitor_all[visitor.date] || 0)
      @newer << (@visitor_new[visitor.date] || 0)
      @repeater << (@visitor_repeater[visitor.date] || 0)
      @reports << {
        :date => Time.at(visitor.date).to_date,
        :count_all => (@visitor_all[visitor.date] || 0),
        :count_newer => (@visitor_new[visitor.date] || 0),
        :count_repeater => (@visitor_repeater[visitor.date] || 0)
      }
    end

    @chart = LazyHighCharts::HighChart.new("graph") do |f|
      f.chart(:type => "line")
      f.title(:text => "アクセス数")
      f.xAxis(:categories => @categories)
      f.yAxis(:max => @all.max, :min => 0, :title => "", :allowDecimals => false)
      f.series(:name => "全て", :data => @all)
      f.series(:name => "新規", :data => @newer)
      f.series(:name => "リピート", :data => @repeater)
    end

  end

  def date
    @reader_date = Reader.group(:date).all
    @reader_all = Reader.count_by_date
    @reader_new = Reader.count_by_date(Visitor::VISITOR_REGION_NEW)
    @reader_repeater = Reader.count_by_date(Visitor::VISITOR_REGION_REPEATER)

    @reports = []
    @categories = []
    @all = []
    @newer = []
    @repeater = []
    @reader_date.each do |date|
      @categories << Time.at(date.date).to_date
      @all << (@reader_all[date.date] || 0)
      @newer << (@reader_new[date.date] || 0)
      @repeater << (@reader_repeater[date.date] || 0)
      @reports << {
        :date => Time.at(date.date).to_date,
        :count_all => (@reader_all[date.date] || 0),
        :count_newer => (@reader_new[date.date] || 0),
        :count_repeater => (@reader_repeater[date.date] || 0)
      }
    end

    @chart = LazyHighCharts::HighChart.new("graph") do |f|
      f.chart(:type => "line")
      f.title(:text => "日付別")
      f.xAxis(:categories => @categories)
      f.yAxis(:max => @all.max, :min => 0, :title => "", :allowDecimals => false)
      f.series(:name => "全て", :data => @all)
      f.series(:name => "新規", :data => @newer)
      f.series(:name => "リピート", :data => @repeater)
    end

  end

  def writer
    # 本当はuserもjoinして名前取得したい
    @reader_user = Reader.joins(:article).group(:user_id).select("user_id")
    reader_user_name = User.where("id IN (:id_list)", {:id_list => @reader_user.map{|user| user.user_id}.join(",")}).select("id, name").index_by(&:id)

    @reader_all = Reader.count_by_user
    @reader_new = Reader.count_by_user(Visitor::VISITOR_REGION_NEW)
    @reader_repeater = Reader.count_by_user(Visitor::VISITOR_REGION_REPEATER)

    @reports = []
    @categories = []
    @all = []
    @newer = []
    @repeater = []
    @reader_user.each do |user|
      @categories << (reader_user_name[user.user_id] != nil ? reader_user_name[user.user_id].name : reader_user_name[user.user_id])
      @all << (@reader_all[user.user_id] || 0)
      @newer << (@reader_new[user.user_id] || 0)
      @repeater << (@reader_repeater[user.user_id] || 0)
      @reports << {
        :writer_name => (reader_user_name[user.user_id] ? reader_user_name[user.user_id].name : reader_user_name[user.user_id]),
        :count_all => (@reader_all[user.user_id] || 0),
        :count_newer => (@reader_new[user.user_id] || 0),
        :count_repeater => (@reader_repeater[user.user_id] || 0)
      }
    end

    @chart = LazyHighCharts::HighChart.new("graph") do |f|
      f.chart(:type => "line")
      f.title(:text => "ライター別")
      f.xAxis(:categories => @categories)
      f.yAxis(:max => @all.max, :min => 0, :title => "", :allowDecimals => false)
      f.series(:name => "全て", :data => @all)
      f.series(:name => "新規", :data => @newer)
      f.series(:name => "リピート", :data => @repeater)
    end

  end

  def article
    @reader_article = Reader.joins(:article).group(:article_id).select("title, article_id")
    @reader_all = Reader.count_by_article
    @reader_new = Reader.count_by_article(Visitor::VISITOR_REGION_NEW)
    @reader_repeater = Reader.count_by_article(Visitor::VISITOR_REGION_REPEATER)

    @reports = []
    @categories = []
    @all = []
    @newer = []
    @repeater = []
    @reader_article.each do |article|
      @categories << article.title
      @all << (@reader_all[article.article_id] || 0)
      @newer << (@reader_new[article.article_id] || 0)
      @repeater << (@reader_repeater[article.article_id] || 0)
      @reports << {
        :title => article.title,
        :count_all => (@reader_all[article.article_id] || 0),
        :count_newer => (@reader_new[article.article_id] || 0),
        :count_repeater => (@reader_repeater[article.article_id] || 0)
      }
    end

    @chart = LazyHighCharts::HighChart.new("graph") do |f|
      f.chart(:type => "line")
      f.title(:text => "記事別")
      f.xAxis(:categories => @categories)
      f.yAxis(:max => @all.max, :min => 0, :title => "", :allowDecimals => false)
      f.series(:name => "全て", :data => @all)
      f.series(:name => "新規", :data => @newer)
      f.series(:name => "リピート", :data => @repeater)
    end

  end

end
