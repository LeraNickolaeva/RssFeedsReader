class User::UsersController < User::BaseController
  load_and_authorize_resource
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new

    @user = User.new(params[:user])
    redirect_to feeds_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to all_users_path, :notice => "User has been deleted!"
  end

  def edit
    # @user = User.find(params[:id])
  end

  def update
    @user.skip_reconfirmation!

    if @user.update(user_params)
      sign_in @user, bypass: true
      flash[:notice] = 'User is updated successfully'
      redirect_to edit_user_user_path
    else
      flash[:alert] = "Can't update user"
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:id, :email, :password, :password_confirmation)
  end
end