# encoding: utf-8

class ArticlesController < ApplicationController
  SEARCH_ARTICLES_SIZE = 12

  before_filter protect_from_forgery, :except => [:fileupload]

  # devise の認証filter
  before_filter :authenticate_user!, :except => [:search, :show, :fileupload]

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
    find_codes
    @articles = Article.where('approved = :approved', {:approved => true})
    @articles = @articles.where("title LIKE :title ESCAPE '$'", {:title => params[:title].gsub(/%/, "$%").gsub(/_/, "$_") + "%"}) unless !params[:title] || params[:title].empty?
    @articles = @articles.where('theme_id = :theme_id', {:theme_id => params[:theme_id].to_i}) unless !params[:theme_id] || params[:theme_id].empty?
    @articles = @articles.where('country_id = :country_id', {:country_id => params[:country_id].to_i}) unless !params[:country_id] || params[:country_id].empty?
    @articles = @articles.where('vihicle_id = :vihicle_id', {:vihicle_id => params[:vihicle_id].to_i}) unless !params[:vihicle_id] || params[:vihicle_id].empty?
    @articles = @articles.where('member_id = :member_id', {:member_id => params[:member_id].to_i}) unless !params[:member_id] || params[:member_id].empty?
    @articles = @articles.where('purpose_id = :purpose_id', {:purpose_id => params[:purpose_id].to_i}) unless !params[:purpose_id] || params[:purpose_id].empty?
    @articles = @articles.where('budget_id = :budget_id', {:budget_id => params[:budget_id].to_i}) unless !params[:budget_id] || params[:budget_id].empty?
    @articles = @articles.where('language_id = :language_id', {:language_id => params[:language_id].to_i}) unless !params[:language_id] || params[:language_id].empty?
    @articles = @articles.where('age_id = :age_id', {:age_id => params[:age_id].to_i}) unless !params[:age_id] || params[:age_id].empty?

    # todo popular はあとで
    @articles = @articles.where('recommended = :recommended', {:recommended => params[:recommended].to_i}) unless !params[:recommended] || params[:recommended].empty?

    @articles = @articles.page(params[:page]).per(SEARCH_ARTICLES_SIZE)

    render :layout => "search"
  end

  # todo top_controller にも定義が重複している。
  TOP_NEWS_SIZE = 4

  def show
    begin
      # @article = Article.where('id = :id', {:id => params[:id]}).joins(:user)
      @article = Article.find(params[:id])
      @related_articles = Article.where('theme_id = :theme_id and approved = :approved', {:theme_id => @article.theme_id, :approved => true}).limit(TOP_NEWS_SIZE)
      @shoveler_articles = Article.where('theme_id = :theme_id and approved = :approved', {:theme_id => @article.theme_id, :approved => true}).limit(TOP_NEWS_SIZE)

    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
      # redirect_to article_url, notice: '記事は存在しません'
    else
      # if (false)
      if (!current_user.admin? && @article.user_id != current_user.id && !@article.approved?)
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
    find_codes
    @article = Article.new

    # @image = Image.new
    # @article.image = @image
    # @url = @image.file.url(:medium) if @image.file
    # @url = "/development/images/39/medium.jpg"

    # @paragraphs = Array.new(1) {Paragraph.new}
    @paragraphs = []
    @article.paragraphs = @paragraphs
    @article
  end

  def create
    paragraphs = params[:article][:paragraphs]
    params[:article].delete(:paragraphs)

    @article = Article.new(params[:article])
    if @article.save
      save_paragraphs(@article.id, paragraphs)
      # redirect_to article_path(:id => @article.id), notice: '投稿しました'
      redirect_to article_path(:id => @article.id), notice: '投稿しました'
    else
      find_codes

      image = Image.find(params[:article][:image_id])
      @url = image.file.url(:medium) if image
    # @paragraphs = Array.new(1) {Paragraph.new}
    # @paragraphs = []
    # @article.paragraphs = @paragraphs

      @paragraphs = @article.paragraphs
      # add_paragraph_objects(paragraphs, @paragraphs)

      render action: 'new'
    end
  end

  def fileupload
    # if (params[:image_id])
    #   @image = Image.find(params[:image_id])
    #   @image.update_attributes(:file => params[:qqfile])
    # else
    #   @image = Image.new(:file => params[:qqfile])
    #   @image.save
    # end
      @image = Image.new(:file => params[:qqfile])
      @image.save

    respond_to do |format|
      format.json {render json: ActiveSupport::JSON.encode({"url" => @image.file.url(:medium), "success" => true, "image" => ActiveSupport::JSON.decode(@image.to_json)})}
    end
  end

  def edit
    find_codes
    begin
      @article = Article.find(params[:id])
      @url = @article.image.file.url(:medium)
      @paragraphs = Paragraph.where("article_id = :article_id", {:article_id => @article.id})
      # if !@paragraphs || @paragraphs.length == 0
      #   @paragraphs = []
      # end
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
    paragraphs = params[:article][:paragraphs]
    params[:article].delete(:paragraphs)

    begin
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
    else
      params[:article][:approved] = false
      params[:article][:recommended] = false
      # transaction 必要
      if @article.update_attributes(params[:article])
        save_paragraphs(params[:id], paragraphs)
        redirect_to article_path(@article), notice: '更新しました'
      else
        find_codes

        @paragraphs = @article.paragraphs
        # add_paragraph_objects(paragraphs, @paragraphs)
  
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
      if @article.destroy
        # if (self.admin_role?)
        #   redirect_to articles_path, notice: @article.title + 'を削除しました'
        # else
        #   redirect_to articles_path, notice: @article.title + 'を削除しました'
        # end
        redirect_to articles_path, notice: @article.title + 'を削除しました'
      else
        redirect_to articles_path, alert: 'エラーが発生しました'
      end
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

  def disrecommend
    begin
      @article = Article.find(params[:id])
      @article.update_attributes(:recommended => false)
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
    else
      redirect_to articles_path
    end
  end

  private
  def find_codes
    # @themes = Theme.all.collect {|model| [model.code, model.id]}
    # # @countries = [["日本", 1]]
    # @countries = Country.all.collect {|model| [model.code, model.id]}
    # @vihicles = Vihicle.all.collect {|model| [model.code, model.id]}
    # @members = Member.all.collect {|model| [model.code, model.id]}
    # @purposes = Purpose.all.collect {|model| [model.code, model.id]}
    # @budgets = Budget.all.collect {|model| [model.code, model.id]}
    # @languages = Language.all.collect {|model| [model.code, model.id]}
    # @ages = Age.all.collect {|model| [model.code, model.id]}
    @themes = Theme.all.collect {|model| [model.value, model.id]}
    # @countries = [["日本", 1]]
    @countries = Country.all.collect {|model| [model.value, model.id]}
    @vihicles = Vihicle.all.collect {|model| [model.value, model.id]}
    @members = Member.all.collect {|model| [model.value, model.id]}
    @purposes = Purpose.all.collect {|model| [model.value, model.id]}
    @budgets = Budget.all.collect {|model| [model.value, model.id]}
    @languages = Language.all.collect {|model| [model.value, model.id]}
    @ages = Age.all.collect {|model| [model.value, model.id]}
  end

  def save_paragraphs(article_id, paragraphs)
    if paragraphs
      if paragraphs.class == Array
        paragraphs.each do |paragraph|
          Paragraph.save_by_article(article_id, paragraph)
        end
      elsif paragraphs.class == HashWithIndifferentAccess
        paragraphs.keys.each do |index|
          Paragraph.save_by_article(article_id, paragraphs[index])
        end
      end
    end
  end

  # def add_paragraph_objects(paragraphs_params, paragraphs_objects)
  #   if (paragraphs_params) 
  #     if paragraphs_params.class == Array
  #       paragraphs_params.each do |paragraph_param|
  #         # if !paragraph_param.id || paragraph_param.empty?
  #           paragraphs_objects << Paragraph.new(paragraph_param)
  #       end
  #     elsif paragraphs_params.class == HashWithIndifferentAccess
  #       paragraphs_params.keys.each do |index|
  #         # if !paragraph_param.id || paragraph_param.empty?
  #           paragraphs_objects << Paragraph.new(paragraphs_params[index])
  #       end
  #     end
  #   end
  # end

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
