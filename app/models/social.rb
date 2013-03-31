class Social < ActiveRecord::Base
  attr_accessible :link, :provider

  belongs_to :user
end
