# encoding: utf-8

class ArticlesController < ApplicationController

  def show
    respondOne
    # @countries = Theme.all.collect {|model| [model.code, model.id]}

    # @country = [name => '日本']
  end

  def new
    findCodes
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      # redirect_to article_path(:id => @article.id), notice: '投稿しました'
      redirect_to article_path(:id => @article.id)
    else
      findCodes
      render action: 'new'
    end
  end

  def edit
    findCodes
    respondOne
  end

  def update
    begin
      @article = Article.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Access invalid article error#{params[:id]}"
      redirect_to "/", notice: '記事は存在しません'
    else
      if @article.update_attributes(params[:article])
        redirect_to article_path(@article)
      else
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
      @article.destroy
      redirect_to "/"  # 一覧があればそちらへ飛ばしたほうがよい
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

  def respondOne
    begin
      @article = Article.find(params[:id])
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
end
