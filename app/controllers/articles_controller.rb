class ArticlesController < ApplicationController

  def show
    @article = Article.find(params[:id])
    # @countries = Theme.all.collect {|model| [model.code, model.id]}

    # @country = [name => '日本']

    # @vihicle = Vihicle.find(@article.vihicle_id)
    # @member = Member.find(@article.member_id)
    # @purpose = Vihicle.find(@article.purpose_id)
    # @budget = Vihicle.find(@article.vihicle_id)
    # @language = Vihicle.find(@article.vihicle_id)
    # @age = Vihicle.find(@article.vihicle_id)

    # @members = Member.all.collect {|model| [model.code, model.id]}
    # @purposes = Purpose.all.collect {|model| [model.code, model.id]}
    # @budgets = Budget.all.collect {|model| [model.code, model.id]}
    # @languages = Language.all.collect {|model| [model.code, model.id]}
    # @ages = Age.all.collect {|model| [model.code, model.id]}
  end

  def new
    findMaster
    @article = Article.new
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      # redirect_to article_path(:id => @article.id), notice: '投稿しました'
      redirect_to article_path(:id => @article.id)
    else
      findMaster
      render action: 'new'
    end
  end

  def edit
    findMaster
    @article = Article.find(params[:id])
  end

  private
  def findMaster
    @themes = Theme.all.collect {|model| [model.code, model.id]}
    # @countries = Theme.all.collect {|model| [model.code, model.id]}
    @vihicles = Vihicle.all.collect {|model| [model.code, model.id]}
    @members = Member.all.collect {|model| [model.code, model.id]}
    @purposes = Purpose.all.collect {|model| [model.code, model.id]}
    @budgets = Budget.all.collect {|model| [model.code, model.id]}
    @languages = Language.all.collect {|model| [model.code, model.id]}
    @ages = Age.all.collect {|model| [model.code, model.id]}
  end
end
