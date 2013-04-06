# encoding: utf-8

class ArticlesController < ApplicationController
  # devise の認証filter
  before_filter :authenticate_user!, :except => [:search, :show]

  require 'analytics/device_region'
  require 'analytics/article_logger_filter'
  include ArticleLoggerFilter

  layout "page", :only => [:show]

  # before_filter :check_user_login, :except => [:search, :show]

  def index
      if (self.user_login?)
        # if (params[:user_id] == current_user.id.to_s)
        #   @articles = Article.where('user_id = :user_id', {:user_id => params[:user_id]}).page(params[:page]).per(12)
        # elsif (!params[:user_id] && self.admin_role?)
        #   @articles = Article.page(params[:page]).per(12)
        # else
        #   redirect_to "/"
        # end
        @articles = Article.where('user_id = :user_id', {:user_id => current_user.id}).page(params[:page]).per(12)
      else
        # @articles = Article.where('approved = :approved', {:approved => true}).page(params[:page]).per(12)
        @articles = []
      end
  end

  def search
    findCodes
    @articles = Article.where('approved = :approved', {:approved => true})
    @articles = @articles.where("title LIKE :title ESCAPE '$'", {:title => params[:title].gsub(/%/, "$%").gsub(/_/, "$_") + "%"}) unless !params[:title] || params[:title].empty?
    @articles = @articles.where('theme_id = :theme_id', {:theme_id => params[:theme_id].to_i}) unless !params[:theme_id] || params[:theme_id].empty?
    # todo 国別
    @articles = @articles.where('vihicle_id = :vihicle_id', {:vihicle_id => params[:vihicle_id].to_i}) unless !params[:vihicle_id] || params[:vihicle_id].empty?
    @articles = @articles.where('member_id = :member_id', {:member_id => params[:member_id].to_i}) unless !params[:member_id] || params[:member_id].empty?
    @articles = @articles.where('purpose_id = :purpose_id', {:purpose_id => params[:purpose_id].to_i}) unless !params[:purpose_id] || params[:purpose_id].empty?
    @articles = @articles.where('budget_id = :budget_id', {:budget_id => params[:budget_id].to_i}) unless !params[:budget_id] || params[:budget_id].empty?
    @articles = @articles.where('language_id = :language_id', {:language_id => params[:language_id].to_i}) unless !params[:language_id] || params[:language_id].empty?
    @articles = @articles.where('age_id = :age_id', {:age_id => params[:age_id].to_i}) unless !params[:age_id] || params[:age_id].empty?
    @articles = @articles.page(params[:page]).per(12)

    render :layout => "search"
  end

  def show
    begin
      # @article = Article.where('id = :id', {:id => params[:id]}).joins(:user)
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
