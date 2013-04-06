class AnalyticsArticle < ActiveRecord::Base
  VISITOR_REGION_NEW = 1
  VISITOR_REGION_REPEATER = 2

  attr_accessible :article_id, :date, :deviceregion, :visitorregion
  belongs_to :article
end
