class AboutUs < ActiveRecord::Base
  acts_as_paranoid

  attr_accessible :content
end
