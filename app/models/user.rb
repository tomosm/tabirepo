class User < ActiveRecord::Base
  USER_TYPE_ADMIN = "1"

  acts_as_paranoid
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable#, :omniauth_providers => [:facebook]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :social_id, :name, :user_type, :gender, :email, :password, :password_confirmation, :remember_me, :provider, :uid, :link, :bio, :image_url
  # attr_accessible :provider # facebook等の認証プロバイダ
  # attr_accessible :uid # 認証プロバイダ内のユーザーID
  # attr_accessible :title, :body

  validates :name, :presence => true
  # validates :password, :presence => true

  has_one :social#, :profile
  has_many :articles

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      # social = Social.create(link: auth.raw_info ? auth.raw_info.link : "", provider: auth.provier)
      user = User.create(
        name: auth.extra.raw_info.name,
        gender: auth.extra.raw_info.gender,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email,
        password: Devise.friendly_token[0,20],
        link: auth.extra.raw_info.link,
        bio: auth.extra.raw_info.bio,
        image_url: auth.info.image
        # social_id: social.id
      )

      # user.profile = Profile.create(photo: auth.info.image)
      # user.social = Social.create(link: auth.raw_info.link)
      # Profile.create(photo: auth.info.image, user_id: user.id)
    end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def admin?
    self.user_type == USER_TYPE_ADMIN
  end

  def signed_by_facebook?
    self.provider && self.provider.to_s.downcase == "facebook"
  end

end
