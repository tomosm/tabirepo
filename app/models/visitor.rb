class Visitor < ActiveRecord::Base
  VISITOR_REGION_NEW = 1
  VISITOR_REGION_REPEATER = 2

  attr_accessible :date, :deviceregion, :visitorregion

  def self.count_by_date(visitorregion = nil)
    if (visitorregion)
      self.where(:visitorregion => visitorregion).group(:date).count(:date)
    else
      self.group(:date).count(:date)
    end
  end
end
