class ArticlePlanning < ActiveRecord::Base
  attr_accessible :article_id, :planning_id

  # has_many :plannings

  belongs_to :article
  belongs_to :planning

  validates :article_id, :presence => true
  validates :planning_id, :presence => true

  def self.save_by_article(article_id, planning_id, checked)
    begin
      article_planning = self.where('article_id = :article_id AND planning_id = :planning_id', {:article_id => article_id, :planning_id => planning_id})
      if article_planning.blank?
        if self.checked?(checked)
          self.create({:article_id => article_id, :planning_id => planning_id})
        end
      else
        if !self.checked?(checked)
          self.destroy(article_planning)
        end
      end
    end
  end

  private
  def self.checked?(checked)
    checked == "1"
  end

end
