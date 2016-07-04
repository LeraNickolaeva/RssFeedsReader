class ProfileCreator::Email < ProfileCreator::Base
  def perform
    nickname = generate_unique_nickname(@user.email.split('@').first)
    @user.create_profile!(nickname: nickname) if @user.profile.nil?
  end
end
