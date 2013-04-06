# encoding: utf-8

class ArticlesController < ApplicationController
  require "device_region"
  
  VIEW_LOG_COOKEI_KEY = "TABI_REPO"

  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :put_analytics_view_log, :only => [:show]

  def index

# before_filter
# todo ログインユーザー、または管理者のみ 
# todo 管理者のみ
    # todo 未承認

      if (self.authenticate_admin_role)
        @articles = Article.page(params[:page]).per(12)
      elsif (params[:user_id])
        @articles = Article.where('user_id = :user_id', {:user_id => params[:user_id]}).page(params[:page]).per(12)
      else
        @articles = Article.where('approved = :approved', {:approved => true}).page(params[:page]).per(12)
      end

    # if (params[:approved] == "0")
    #   @articles = Article.where('approved <> :approved', {:approved => 1}).page(params[:page]).per(12)
    # else
    #   if (current_user.admin?)
    #     @articles = Article.page(params[:page]).per(12)
    #   elsif (params[:user_id])
    #     @articles = Article.where('user_id = :user_id', {:user_id => params[:user_id]}).page(params[:page]).per(12)
    #   else
    #     @articles = Article.where('approved = :approved', {:approved => 1}).page(params[:page]).per(12)
    #   end
    # end 
  end

  def show
    begin
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
      # redirect_to article_url, notice: '記事は存在しません'
    else
      if (false)
      # if (!current_user.admin? && @article.user_id != params[:id] && !@article.approved?)
        redirect_to "/", notice: '記事は存在しません'
      else
        respond_to do |format|
          format.html
          # format.json {render json:@article}
        end
      end
    end
  end

  def new
    findCodes
    @article = Article.new
    # @paragraphs = Array.new(1) {Paragraph.new}
    @paragraphs = []
    @article.paragraphs = @paragraphs
    @article
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      # redirect_to article_path(:id => @article.id), notice: '投稿しました'
      redirect_to article_path(:id => @article.id)
    else
      findCodes
    # @paragraphs = Array.new(1) {Paragraph.new}
    # @paragraphs = []
    # @article.paragraphs = @paragraphs

    @paragraphs = @article.paragraphs

      render action: 'new'
    end
  end

  def edit
    findCodes
    begin
      @article = Article.find(params[:id])
      @paragraphs = Paragraph.where("article_id = :article_id", {:article_id => @article.id})
      if !@paragraphs || @paragraphs.length == 0
        @paragraphs = []
      end
      # @paragraphs.add(Paragraph.new)
      # @article.paragraphs = @paragraphs
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
      # redirect_to article_url, notice: '記事は存在しません'
    else
      respond_to do |format|
        format.html
        # format.json {render json:@article}
      end
    end
  end

  def update
    begin
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
    else
      @article.update_attributes(:approved => false, :recommended => false)
      if @article.update_attributes(params[:article])
        redirect_to article_path(@article)
      else
        findCodes

        @paragraphs = @article.paragraphs
        render action: 'edit'
      end
    end
  end

  def destroy
    begin
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
    else
      redirect_to articles_path
      # redirect_to "/"  # 一覧があればそちらへ飛ばしたほうがよい
    end
  end

  def approve
    begin
      @article = Article.find(params[:id])
      @article.update_attributes(:approved => true)
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
    else
      redirect_to articles_path
    end
  end

  def disapprove
    begin
      @article = Article.find(params[:id])
      @article.update_attributes(:approved => false)
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
    else
      redirect_to articles_path
    end
  end

  def recommend
    begin
      @article = Article.find(params[:id])
      @article.update_attributes(:recommended => true)
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
    else
      redirect_to articles_path
    end
  end

  # for analytics
  def put_analytics_view_log
    begin
      article = Article.find(params[:id])
      # 記事と同じユーザー、あるいは管理者はカウントしない
      if (current_user && (current_user.id == article.user_id || current_user.admin?))
        return;
      end

      today = Date.today.to_time.to_i
      analytics_article = AnalyticsArticle.new({
        :article_id => article.id,
        :date => today,
        :deviceregion => DeviceRegion.getValue(request.env["HTTP_USER_AGENT"])
        });

      realCookieKey = VIEW_LOG_COOKEI_KEY + article.id.to_s
      if (cookies[realCookieKey]) 
        if (cookies[realCookieKey].to_i < Date.today.prev_day.to_time.to_i)
          # repeater
          analytics_article.visitorregion = AnalyticsArticle::VISITOR_REGION_REPEATER
          cookies[realCookieKey] = today
          analytics_article.save
        end
      else
        # new
        analytics_article.visitorregion = AnalyticsArticle::VISITOR_REGION_NEW
        cookies[realCookieKey] = today
        analytics_article.save
      end
    end
  end

  private
  def findCodes
    @themes = Theme.all.collect {|model| [model.code, model.id]}
    # @countries = Theme.all.collect {|model| [model.code, model.id]}
    @vihicles = Vihicle.all.collect {|model| [model.code, model.id]}
    @members = Member.all.collect {|model| [model.code, model.id]}
    @purposes = Purpose.all.collect {|model| [model.code, model.id]}
    @budgets = Budget.all.collect {|model| [model.code, model.id]}
    @languages = Language.all.collect {|model| [model.code, model.id]}
    @ages = Age.all.collect {|model| [model.code, model.id]}
  end

  # def respondOne
  #   begin
  #     @article = Article.find(params[:id])
  #   rescue ActiveRecord::RecordNotFound
  #     logger.error "Access invalid article error#{params[:id]}"
  #     redirect_to "/", notice: '記事は存在しません'
  #     # redirect_to article_url, notice: '記事は存在しません'
  #   else
  #     respond_to do |format|
  #       format.html
  #       # format.json {render json:@article}
  #     end
  #   end
  # end

end
