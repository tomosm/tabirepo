class AnalyticsArticle < ActiveRecord::Base

  attr_accessible :article_id, :date, :deviceregion, :visitorregion
  belongs_to :article

  def self.find_by_popular_article
    self.order("count_article_id DESC").group(:article_id).count(:article_id)
  end

  def self.find_by_popular_user
    self.order("count_user_id DESC").group(:user_id).count(:user_id)
  end

  def self.count_by_date(visitorregion)
    self.where(:visitorregion => visitorregion).group(:date).count(:date)
  end

end
