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
  has_many :article_plannings, :dependent => :destroy
  has_many :plannings, :through => :article_plannings

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

  def self.with_popular
    reader = Reader.arel_table
    sql_for_count_article_id_by_popular = reader.project(reader[:article_id], reader[:article_id].count.as('count_article_id')).group(reader[:article_id]).to_sql
    self.joins("inner join (#{sql_for_count_article_id_by_popular}) popular on articles.id = popular.article_id").reorder('popular.count_article_id DESC, articles.created_at DESC')
  end

  def self.with_planning(planning_id)
    self.joins(:article_plannings).where('article_plannings.planning_id = :planning_id', {planning_id: planning_id})
    # self.joins("inner join (SELECT \"readers\".\"article_id\", COUNT(\"readers\".\"article_id\") AS count_article_id FROM \"readers\"  GROUP BY \"readers\".\"article_id\") popular on id = popular.article_id").reorder('popular.count_article_id DESC, articles.created_at DESC')
  end
end
