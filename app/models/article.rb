class Article < ActiveRecord::Base
  acts_as_paranoid

  attr_accessible :age_id, :budget_id, :description, :entry_program, :language_id, :member_id, :purpose_id, :theme_id, :title, :vihicle_id, :photo
  belongs_to :age
  belongs_to :budget
  belongs_to :language
  belongs_to :member
  belongs_to :purpose
  belongs_to :theme
  belongs_to :vihicle
  # has_attached_file :photo, :styles => {:large => "640x480>", :medium => "300x300>", :thumb => "100x100>"}
  has_attached_file :photo, :styles => {:medium => "400x300>", :thumb => "200x150>"},
  :url  => "/development/articles/:id/:style/:basename.:extension",
  :path => ":rails_root/public/development/articles/:id/:style/:basename.:extension" 

  validates :title, :presence => true, :length => {:maximum => 20}
  validates :description, :presence => true, :length => {:maximum => 2000}
  validates :age, :presence => true
  validates :budget, :presence => true
  validates :language, :presence => true
  validates :member, :presence => true
  validates :purpose, :presence => true
  validates :theme, :presence => true
  validates :vihicle, :presence => true
  validates_attachment :photo, :presence => true,
  :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
  # :size => { :in => 0..1024.kilobytes }
  :size => { :in => 0..10240.kilobytes }
end
