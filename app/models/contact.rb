class Contact < ActiveRecord::Base
  acts_as_paranoid

  attr_accessible :content, :email, :name

  validates :name, :presence => true
  validates :email, :presence => true
  validates :content, :presence => true
  
end
