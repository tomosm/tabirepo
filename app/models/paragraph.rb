class Paragraph < ActiveRecord::Base
  attr_accessible :article_id, :sentence, :subtitle
  default_scope :order => 'id ASC'

  belongs_to :articles

  # validates :article_id, :presence => true
  validates :subtitle, :presence => true, :length => {:maximum => 50}
  validates :sentence, :presence => true, :length => {:maximum => 2000}
end
