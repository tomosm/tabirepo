class Paragraph < ActiveRecord::Base
  acts_as_paranoid
  attr_accessible :article_id, :sentence, :subtitle, :deleted_at, :image_id, :image
  default_scope :order => 'id ASC'

  belongs_to :articles
  belongs_to :image

  # validates :article_id, :presence => true
  # validates :subtitle, :presence => true, :length => {:maximum => 50}
  # validates :sentence, :presence => true, :length => {:maximum => 2000}
  validates :subtitle, :presence => true
  validates :sentence, :presence => true

  def self.save_by_article(article_id, params)
    if (params[:id] && !params[:id].empty?)
      begin
        paragraph = self.find(params[:id])
        if (params[:deleted_at] && !params[:deleted_at].empty?)
          paragraph.destroy          
        else
          params.delete(:deleted_at)
          paragraph.update_attributes(params)
        end
      end
    else
      if (!params[:deleted_at] || params[:deleted_at].empty?)
        params[:article_id] = article_id
        self.new(params).save
      end
    end
  end
end
