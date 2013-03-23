class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # def passthru
  #   send(params[:provider]) if providers.include?(params[:provider])
  # end

  # protected

  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)
    if @user.persisted?
      sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
      # flash[:notice] = "Athentication successful!"
      # # flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      # # sign_in(:user, @user)
      # # # redirect_to root_path
      # # # todo 前のページへ
      # # redirect_to '/'
      # # session(:user_return_to)
      # sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def twitter
    raise "Implement me for twitter"
  end

  # private

  # def providers
  #   ["facebook", "twitter"]
  # end
end
