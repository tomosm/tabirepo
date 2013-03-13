class Article < ActiveRecord::Base
  attr_accessible :age_id, :budget_id, :description, :entry_program, :language_id, :member_id, :purpose_id, :theme_id, :title, :vihicle_id
  belongs_to :age
  belongs_to :budget
  belongs_to :language
  belongs_to :member
  belongs_to :purpose
  belongs_to :theme
  belongs_to :vihicle

  validates :title, :presence => true
  validates :description, :presence => true
  validates :age, :presence => true
  validates :budget, :presence => true
  validates :language, :presence => true
  validates :member, :presence => true
  validates :purpose, :presence => true
  validates :theme, :presence => true
  validates :vihicle, :presence => true
end
