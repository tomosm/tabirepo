class AnalyticsVisitor < ActiveRecord::Base
  VISITOR_REGION_NEW = 1
  VISITOR_REGION_REPEATER = 2

  attr_accessible :date, :deviceregion, :visitorregion
end
