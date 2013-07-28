class Planning < ActiveRecord::Base
  attr_accessible :end, :name, :start
  default_scope :order => 'start DESC'

  has_many :article_plannings, :dependent => :destroy
  has_many :articles, :through => :article_plannings

  # belongs_to :articles
end
