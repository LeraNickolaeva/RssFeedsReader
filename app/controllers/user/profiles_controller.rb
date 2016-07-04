class User::ProfilesController < User::BaseController
  before_action :load_profile


  def update
    if @profile.update(profile_params)

      flash[:notice] = 'Profile is updated successfully'
      redirect_to edit_user_profile_path
    else
      flash[:alert] = "Can't update profile"
      render :edit
    end
  end

  def destroy
    if @profile.destroy
      redirect_to root_path
    end
  end

  def profile_params
    params.require(:profile)
        .permit(:first_name, :last_name, :nickname,  :avatar,
                :avatar_cache, :remove_avatar, :profile_type, :avatar_size)
  end

  def load_profile
    @profile = current_user.profile || current_user.build_profile
  end
end
