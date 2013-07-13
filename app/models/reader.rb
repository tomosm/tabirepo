class Reader < ActiveRecord::Base
  attr_accessible :article_id, :date, :deviceregion, :visitorregion, :last_article_id
  belongs_to :article

  def self.find_by_popular_article
    self.order("count_article_id DESC").group(:article_id).count(:article_id)
  end

  def self.find_by_popular_user
    self.order("count_user_id DESC").group(:user_id).count(:user_id)
  end

  def self.count_by_date(visitorregion = nil)
    self.count_by(:date, visitorregion)
  end

  def self.count_by_user(visitorregion = nil)
    if (visitorregion)
      self.where(:visitorregion => visitorregion).joins(:article).group(:user_id).count(:user_id)
    else
      self.joins(:article).group(:user_id).count(:user_id)
    end
  end

  def self.count_by_article(visitorregion = nil)
    self.count_by(:article_id, visitorregion)
  end

  private
  def self.count_by(count_type, visitorregion = nil)
    if (visitorregion)
      self.where(:visitorregion => visitorregion).group(count_type).count(count_type)
    else
      self.group(count_type).count(count_type)
    end
  end
end
