class Theme < ActiveRecord::Base
  attr_accessible :code
  has_many :articles
end
