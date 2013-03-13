class Member < ActiveRecord::Base
  attr_accessible :code
  has_many :article
end
