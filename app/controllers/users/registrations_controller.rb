class Users::RegistrationsController < Devise::RegistrationsController

  def create
    super
    if user_signed_in? and session[:sp_id].present?
      SocialProvider.find_by(id: session[:sp_id],user_id: nil).update(user_id: current_user.id)
    end
  end
  end