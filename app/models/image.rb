class Image < ActiveRecord::Base
  acts_as_paranoid
  attr_accessible :file

  has_attached_file :file,
  Proc.new {
    # if Rails.env == 'development'
    if Rails.env == 'production'
      {
        # todo s3
        :styles => {:medium => "640x480>", :thumb => "180x135>", :smartfon => "480x360>"},
        :url  => "/production/images/:id/:style.:extension",
        :path => ":rails_root/public/production/images/:id/:style.:extension" 

  #       :styles => {:medium => "640x480>", :thumb => "180x135>", :smartfon => "480x360>"},
  #       :storage => :s3,
  #       :s3_credentials => "#{Rails.root}/config/s3.yml",


  # # :bucket => "tabirepo.tk",
  # # :access_key_id => "AKIAJJS7KV3CHQE5OZOQ",
  # # :secret_access_key => "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",
  # # :s3_host_name => "s3-website-ap-northeast-1.amazonaws.com",


  #       # :s3_permissions => :private,
  #       # :s3_permissions => "piace777",
  #       :path => ":attachment/:id/:style.:extension"#,
  #       # :bucket => 'paperclip.tabirepo.com'
      }
    else
      {
        :styles => {:medium => "640x480>", :thumb => "180x135>", :smartfon => "480x360>"},
        :url  => "/development/images/:id/:style.:extension",
        :path => ":rails_root/public/development/images/:id/:style.:extension" 
      }
    end
  }.call

  validates_attachment :file, :presence => true,
    :content_type => { :content_type => ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'] },
    :size => { :in => 0..10240.kilobytes }
end
