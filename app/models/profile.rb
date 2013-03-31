class Profile < ActiveRecord::Base
  attr_accessible :about, :photo, :user_id
  belongs_to :user

  default_scope :order => 'created_at DESC'
end
