class ProfileCreator::Auth::Base < ProfileCreator::Base
  def initialize(user, auth)
    @user, @auth = user, auth
  end

  def perform
    nickname = generate_unique_nickname(nickname_from_auth)
    @user.create_profile!(nickname: nickname) if @user.profile.nil?
  end

  private

  def nickname_from_auth
    @auth[:info][:nickname]
  end
end
