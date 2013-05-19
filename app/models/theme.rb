class Theme < ActiveRecord::Base
  attr_accessible :code, :value, :color
  has_many :articles
end
