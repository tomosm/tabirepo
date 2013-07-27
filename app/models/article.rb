class Article < ActiveRecord::Base
  acts_as_paranoid
  default_scope :order => 'created_at DESC'

  attr_accessible :age_id, :budget_id, :outline, :language_id, :member_id, :purpose_id, :theme_id, :title, :vihicle_id, :country_id, :user_id, :approved, :recommended, :image_id, :image, :applied

  belongs_to :age
  belongs_to :budget
  belongs_to :country
  belongs_to :language
  belongs_to :member
  belongs_to :purpose
  belongs_to :theme
  belongs_to :vihicle
  belongs_to :user
  belongs_to :image

  has_many :paragraphs

  # validates :title, :presence => true
  # validates :theme_id, :presence => true
  # validates :country_id, :presence => true
  # validates :vihicle_id, :presence => true
  # validates :member_id, :presence => true
  # validates :purpose_id, :presence => true
  # validates :budget_id, :presence => true
  # validates :language_id, :presence => true
  # validates :age_id, :presence => true
  # validates :outline, :presence => true
  # validates :image_id, :presence => true

  def approved?
    !!self.approved
  end

  def applied?
    !!self.applied
  end

  def recommended?
    !!self.recommended
  end

  def write_by?(user)
    user && user.id == self.user_id
  end
end
