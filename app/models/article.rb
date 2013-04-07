class Article < ActiveRecord::Base
  acts_as_paranoid
  default_scope :order => 'created_at DESC'

  attr_accessible :age_id, :budget_id, :outline, :entry_program, :language_id, :member_id, :purpose_id, :theme_id, :title, :vihicle_id, :country_id, :photo, :user_id, :approved, :recommended
  #, :paragraphs_attributes
  belongs_to :age
  belongs_to :budget
  belongs_to :language
  belongs_to :member
  belongs_to :purpose
  belongs_to :theme
  belongs_to :vihicle
  belongs_to :user

  has_many :paragraphs
#  accepts_nested_attributes_for :paragraphs, :allow_destroy => true

  # has_attached_file :photo, :styles => {:large => "640x480>", :medium => "300x300>", :thumb => "100x100>"}
  # has_attached_file :photo, :styles => {:medium => "560x420>", :thumb => "200x156>"},
  has_attached_file :photo, :styles => {:medium => "640x480>", :thumb => "160x120>"},
  :url  => "/development/articles/:id/:style/:basename.:extension",
  :path => ":rails_root/public/development/articles/:id/:style/:basename.:extension" 

  validates :title, :presence => true, :length => {:maximum => 50}
  validates_attachment :photo, :presence => true,
  :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
  # :size => { :in => 0..1024.kilobytes }
  :size => { :in => 0..10240.kilobytes }
  # validates :country_code, inclusion: { in: COUNTRY_NUMS }
  validates :theme_id, :presence => true
  validates :country_id, :presence => true
  validates :vihicle_id, :presence => true
  validates :member_id, :presence => true
  validates :purpose_id, :presence => true
  validates :budget_id, :presence => true
  validates :language_id, :presence => true
  validates :age_id, :presence => true
  validates :outline, :presence => true, :length => {:maximum => 2000}

  def approved?
    !!self.approved
  end

  def recommended?
    !!self.recommended
  end

  def write_by?(user)
    user && user.id == self.user_id
  end
end
