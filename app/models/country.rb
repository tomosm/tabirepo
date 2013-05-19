class Country < ActiveRecord::Base
  attr_accessible :code, :value
  has_many :articles
end
