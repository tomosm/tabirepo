class ArticlePlanning < ActiveRecord::Base
  attr_accessible :article_id, :planning_id

  has_many :plannings

  validates :article_id, :presence => true
  validates :planning_id, :presence => true

  def self.save_by_article(article_id, planning_id, checked)
    begin
      article_planning = self.where('article_id = :article_id', {:article_id => article_id})
      if article_planning.blank?
        if self.checked?(checked)
          self.new({:article_id => article_id, :planning_id => planning_id}).save
        end
      else
        if self.checked?(checked)
          article_planning.destroy
        end
      end
    end
  end

  def self.create_list_by_params(params)
    list = [];
    params.keys.each do |planning_id|
      list.push(self.new({:article_id => params[:article_id], :planning_id => params[:planning_id]}))
    end
    list
  end

  private
  def self.checked?(checked)
    checked != "1"
  end

end
