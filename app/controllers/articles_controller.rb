# encoding: utf-8

class ArticlesController < ApplicationController
  SEARCH_ARTICLES_SIZE = 12

  before_filter protect_from_forgery, :except => [:fileupload, :fileupload_paragraph]

  # devise の認証filter
  before_filter :authenticate_user!, :except => [:search, :show, :fileupload, :fileupload_paragraph, :writer]

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
    find_codes_with_all_plannings
    # @articles = Article.where('approved = :approved', {:approved => true})
    @articles = Article.where('applied = :applied', {:applied => true})
    if (current_user && current_user.admin?)
    # todo 本当はよくない false とか null などは不要だが@articlesを生成するため
      # @articles = Article
    else
      @articles = @articles.where('approved = :approved', {:approved => true})
    end

    @articles = @articles.where("title LIKE :title ESCAPE '$'", {:title => params[:title].gsub(/%/, "$%").gsub(/_/, "$_") + "%"}) unless params[:title].blank?
    @articles = @articles.where('theme_id = :theme_id', {:theme_id => params[:theme_id].to_i}) unless params[:theme_id].blank?
    @articles = @articles.where('country_id = :country_id', {:country_id => params[:country_id].to_i}) unless params[:country_id].blank?
    @articles = @articles.where('vihicle_id = :vihicle_id', {:vihicle_id => params[:vihicle_id].to_i}) unless params[:vihicle_id].blank?
    @articles = @articles.where('member_id = :member_id', {:member_id => params[:member_id].to_i}) unless params[:member_id].blank?
    @articles = @articles.where('purpose_id = :purpose_id', {:purpose_id => params[:purpose_id].to_i}) unless params[:purpose_id].blank?
    @articles = @articles.where('budget_id = :budget_id', {:budget_id => params[:budget_id].to_i}) unless params[:budget_id].blank?
    @articles = @articles.where('language_id = :language_id', {:language_id => params[:language_id].to_i}) unless params[:language_id].blank?
    @articles = @articles.where('age_id = :age_id', {:age_id => params[:age_id].to_i}) unless params[:age_id].blank?
    @articles = @articles.where('recommended = :recommended', {:recommended => params[:recommended].to_i}) unless params[:recommended].blank?
    @articles = @articles.with_popular unless params[:popular].blank?
    @articles = @articles.with_planning(params[:planning_id]) unless params[:planning_id].blank?

    @articles = @articles.page(params[:page]).per(SEARCH_ARTICLES_SIZE)

    render :layout => "search"
  end

  def writer
    begin
      @articles = Article.where('user_id = :user_id AND applied = :applied AND approved = :approved', {:user_id => params[:id], :applied => true, :approved => true}).page(params[:page]).per(SEARCH_ARTICLES_SIZE)
      @writer = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid user error#{params[:id]}"
      redirect_to "/", notice: '指定されたライターは存在しません'
    end
  end

  # todo top_controller にも定義が重複している。
  TOP_NEWS_SIZE = 4

  def show
    begin
      # @article = Article
      # @article = Article.where('id = :id', {:id => params[:id]}).joins(:user)

      @article = get_article_by_conditions()
      @related_articles = Article.where('theme_id = :theme_id and approved = :approved and applied = :applied', {:theme_id => @article.theme_id, :approved => true, :applied => true}).limit(TOP_NEWS_SIZE)
      # @shoveler_articles = Article.where('theme_id = :theme_id and approved = :approved', {:theme_id => @article.theme_id, :approved => true}).limit(TOP_NEWS_SIZE)

      # @shoveler_articles = Article.joins("LEFT JOIN readers ON articles.id = readers.article_id").where('readers.last_article_id = :last_article_id', {:last_article_id => @article.id}).order("date DESC").limit(TOP_NEWS_SIZE)

      next_articles_ids = Reader.where('last_article_id = :last_article_id', {:last_article_id => @article.id}).order("date DESC").pluck(:article_id)
      @shoveler_articles = Article.where('id IN (:articles_ids) AND approved = :approved AND applied = :applied', {:articles_ids => next_articles_ids, :theme_id => @article.theme_id, :approved => true, :applied => true}).limit(TOP_NEWS_SIZE)
    # @reader_user = Reader.joins(:article).group(:user_id).select("user_id")
    # reader_user_name = User.where("id IN (:id_list)", {:id_list => @reader_user.map{|user| user.user_id}.join(",")}).select("id, name").index_by(&:id)

    # @reader_all = Reader.count_by_user
    # @reader_new = Reader.count_by_user(Visitor::VISITOR_REGION_NEW)
    # @reader_repeater = Reader.count_by_user(Visitor::VISITOR_REGION_REPEATER)

    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
      # redirect_to article_url, notice: '記事は存在しません'
    else
      # if (false)
      if (current_user && !current_user.admin? && @article.user_id != current_user.id && !@article.approved?)
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
    @paragraphs = []
    @article.paragraphs = @paragraphs
    @article
  end

  def create
    notice = "一時保存のため記事を公開する場合は投稿が必要になります"
    if (params[:save])
      params[:article][:applied] = true
      notice = "編集部により記事が承認されたのちに、旅レポに記事が公開されます"
    end

    paragraphs = params[:article][:paragraphs]
    plannings = params[:article][:plannings]

    params[:article].delete(:paragraphs)
    params[:article].delete(:plannings)

    @article = Article.new(params[:article])
    if @article.save
      save_paragraphs(@article.id, paragraphs)
      save_article_planning(@article.id, plannings)
      # redirect_to article_path(:id => @article.id), notice: '投稿しました'
      redirect_to article_path(:id => @article.id), notice: notice
    else
      find_codes

      image = params[:article][:image_id].blank? ? nil : Image.find(params[:article][:image_id])
      @photo_url = image.file.url(:medium) if image
    # @paragraphs = Array.new(1) {Paragraph.new}
    # @paragraphs = []
    # @article.paragraphs = @paragraphs

    # TODO エラー時パラグラフが復元されない 

      @paragraphs = @article.paragraphs

# todo paragraph images

      # add_paragraph_objects(paragraphs, @paragraphs)
      # @article_plannings = ArticlePlanning.create_list_by_params(plannings)

      render action: 'new'
    end
  end

  def edit
    find_codes
    begin
      # @article = Article.find(params[:id])
      @article = get_article_by_conditions()
      @photo_url = @article && @article.image && @article.image.file.url(:medium) || nil
      @paragraphs = Paragraph.where("article_id = :article_id", {:article_id => @article.id})
      @article_paragraphs = ArticlePlanning.where("article_id = :article_id", {:article_id => @article.id})
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
    plannings = params[:article][:plannings]

    params[:article].delete(:paragraphs)
    params[:article].delete(:plannings)

    begin
      @article = get_article_by_conditions()
      # @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
    else
      params[:article][:approved] = false
      params[:article][:recommended] = false
      # transaction 必要
      if @article.update_attributes(params[:article])
        save_paragraphs(params[:id], paragraphs)
        save_article_planning(@article.id, plannings)
        redirect_to article_path(@article), notice: '更新しました'
      else
        find_codes

        @paragraphs = @article.paragraphs
        # @article_plannings = ArticlePlanning.create_list_by_params(plannings)
        # add_paragraph_objects(paragraphs, @paragraphs)
  
        render action: 'edit'
      end
    end
  end

  def destroy
    begin
      @article = get_article_by_conditions()
      # @article = Article.find(params[:id])
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
      @article = get_article_by_conditions()
      # @article = Article.find(params[:id])
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
      @article = get_article_by_conditions()
      # @article = Article.find(params[:id])
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
      @article = get_article_by_conditions()
      # @article = Article.find(params[:id])
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
      @article = get_article_by_conditions()
      # @article = Article.find(params[:id])
      @article.update_attributes(:recommended => false)
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
    else
      redirect_to articles_path
    end
  end

  def apply
    begin
      @article = get_article_by_conditions()
      # @article = Article.find(params[:id])
      @article.update_attributes(:applied => true)
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
    else
      redirect_to articles_path
    end
  end

  private
  def find_codes
    @themes = Theme.all.collect {|model| [model.value, model.id]}
    @countries = Country.all.collect {|model| [model.value, model.id]}
    @vihicles = Vihicle.all.collect {|model| [model.value, model.id]}
    @members = Member.all.collect {|model| [model.value, model.id]}
    @purposes = Purpose.all.collect {|model| [model.value, model.id]}
    @budgets = Budget.all.collect {|model| [model.value, model.id]}
    @languages = Language.all.collect {|model| [model.value, model.id]}
    @ages = Age.all.collect {|model| [model.value, model.id]}
    @plannings = Planning.where('start <= :select_date AND :select_date <= end', {:select_date => Date.today.to_s})
  end

  def find_codes_with_all_plannings
    find_codes
    @plannings = Planning.all.collect {|model| [model.name, model.id]}
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

  def save_article_planning(article_id, plannings)
    if plannings
      # if plannings.class == Array
      #   plannings.each do |planning|
      #     ArticlePlanning.save_by_article(article_id, planning)
      #   end
      # elsif plannings.class == HashWithIndifferentAccess
      if plannings.class == HashWithIndifferentAccess
        plannings.keys.each do |planning_id|
          ArticlePlanning.save_by_article(article_id, planning_id, plannings[planning_id]["id"])
        end
      end
    end
  end

  def get_article_by_conditions
    articles = Article.where('id = :id', {:id => params[:id]})
    if current_user
      if !current_user.admin?
        articles = articles.where('(user_id = :user_id) OR (user_id <> :user_id AND approved = :approved)', {:user_id => current_user.id, :approved => true})
      end
      articles = articles.where('(user_id = :user_id) OR (user_id <> :user_id AND :applied)', {:user_id => current_user.id, :applied => true})
    else
      articles = articles.where('applied = :applied', {:applied => true})
      articles = articles.where('approved = :approved', {:approved => true})
    end
    raise ActiveRecord::RecordNotFound if articles.length == 0
    articles[0]
  end

  # def create_plannings_by_params(params)
  #   return [] if (!params || params.length == 0)
  #   list = [];
  #   params.keys.each do |planning_id|
  #     list.push(self.new({:article_id => params[:article_id], :planning_id => params[:planning_id]}))
  #   end
  #   list
  # end

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
