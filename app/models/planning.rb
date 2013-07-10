class Planning < ActiveRecord::Base
  attr_accessible :end, :name, :start
  default_scope :order => 'start DESC'

  belongs_to :articles
end
